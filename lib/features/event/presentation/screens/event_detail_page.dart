import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:kese_events/core/shared_widgets/custome_button_auth.dart';
import 'package:kese_events/core/shared_widgets/custome_icon_button.dart';
import 'package:kese_events/core/shared_widgets/event_card.dart';
import 'package:kese_events/core/shared_widgets/event_loading_card.dart';
import 'package:kese_events/core/utils/colors.dart';
import 'package:kese_events/core/utils/fonts.dart';
import 'package:kese_events/features/event/bloc/event_bloc/event_bloc.dart';
import 'package:kese_events/features/event/bloc/event_bloc/event_event.dart';
import 'package:kese_events/features/event/bloc/event_bloc/event_state.dart';
import 'package:kese_events/features/event/bloc/event_detail_bloc/event_detail_bloc.dart';
import 'package:kese_events/features/event/bloc/event_detail_bloc/event_detail_event.dart';
import 'package:kese_events/features/event/bloc/event_detail_bloc/event_detail_state.dart';
import 'package:kese_events/features/event/dataprovider/event_dataprovider.dart';
import 'package:kese_events/features/event/presentation/widgets/events_text.dart';
import 'package:kese_events/features/notification/notification_cubit/notification_cubit.dart';
import 'package:kese_events/features/payment/presentation/screens/payment_page.dart';
import 'package:kese_events/injector.dart';
import 'package:kese_events/models/event/event.dart';
import 'package:kese_events/models/user/organizer.dart';

class EventDetailPage extends StatefulWidget {

  static const String routeName = "/event_detail_page";
  final Event event;
  // final eventProvider = EventDataProvider();

  const EventDetailPage({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {

  final scrollController = ScrollController();
  final NotificationCubit notificationCubit = DependencyInjector.getNotificationCubit()!;

    @override
  void initState() {
    super.initState();
  }

  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<EventDetailBloc>(context);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    BlocProvider.of<EventDetailBloc>(context).add(GetEventDetail(widget.event.id));
    Event event = Event(
                  createdDate: "createdDate",
                  updatedDate: "updatedDate",
                  id: 1,
                  name: "name",
                  description: "description",
                  eventEndDate: DateTime.now(),
                  eventStartDate: DateTime.now(),
                  price: 123456,
                  thumbnail: "thumbnail",
                  organizerId: Organizer(
                    id: 1,
                     name: "name",
                     profilePicture: "profilePicture", 
                     website: "website", 
                     contactEmail: "contactEmail", 
                     description: "description"
                     ), tags: [], location: '', capacity: 12);
    return Stack(
      children:
      [ 
        Container(
        color: whitishBackground,
        child: Column(
          children: [
            BlocBuilder<EventDetailBloc, EventDetailState>(
                builder: (context, state) {
              if (state is EventDetailLoading) {
                return loadingIndicator();
      
                // return SizedBox(
                //   height: screenHeight * 0.3,
                //   child: ListView(
                //     scrollDirection: Axis.horizontal,
                //     shrinkWrap: true,
                //     physics: const BouncingScrollPhysics(),
                //     children: const [
                //       EventLoadingCard(),
                //       EventLoadingCard(),
                //       EventLoadingCard()
                //     ],
                //   ),
                // );
              }
              
      
              bool isLoading = false;
      
              if (state is EventDetailFailure) {
                print(state.msg);
                notificationCubit.errorNotification(message: state.msg);
              } 
                if (state is EventDetailFailure) {
                  notificationCubit.errorNotification(message: state.msg);
                 }
      
              print(state);
              if (state is EventDetailSuccess) {
                event = state.event;
              }
      
              return Container(
                height: screenHeight,
                child: Column(
                  children: [
                    Stack(
                      children:[
                       AspectRatio(
                         aspectRatio: 1.2,
                         child: CachedNetworkImage(
                            // width: screenWidth * 0.65,
                            // height: screenHeight * 0.4,
                            imageUrl: event.thumbnail,
                            errorWidget: (context, url, error) => Image.asset(event.thumbnail),
                            // SvgPicture.string(logo),
                            fit: BoxFit.cover,
                                              ),
                       ),
                        
    
                       Positioned(
                            top: screenHeight * 0.05, // Adjust the top position as needed
                            left: screenWidth * 0.03, // Adjust the left position as needed
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                              
                              IconButton(
                                icon: Icon(Icons.arrow_back, color: whitishBackground,),
                                onPressed: () {
                                  Navigator.of(context).pop(); // Pop the current page
                                },
                              ),
                           const EventsText(msg: "Details",
                           color: whitishBackground,), ]
                                    ),
                        ),
                      ] 
                    ),
                    Container(
                      color: whitishBackground, // Set your desired color
                      width: screenWidth, // Adjust the width as needed
                      // height: screenHeight * 0.55,
                      // margin: EdgeInsets.all(screenWidth *0.1),
                      margin: EdgeInsets.fromLTRB(screenWidth *0.05, screenWidth *0.1, screenWidth *0.05, screenWidth *0.1),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(
                          //   height: screenHeight * 0.05,
                          // ),
                          Container(
                            child: Text(
                              event.name,
                               style: TextStyle(
                              color: blackText,
                              fontFamily: Poppins, 
                              fontSize: screenWidth * 0.08, 
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.none),
                              )),
                              SizedBox(height: screenHeight * 0.016,),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Container(
                              width: screenWidth * 0.15,
                              height: screenWidth * 0.15,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(239, 227, 220, 220),
                                 borderRadius: BorderRadius.all(Radius.circular(15)),

                              ),
                              child: Icon(Icons.calendar_month,
                              color: themeColor,
                              size: screenWidth *0.08,),
                            ),
                            SizedBox(
                              width: screenWidth*0.05,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Text(DateFormat('d MMMM, y').format(event.eventStartDate),
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                // textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: blackText,
                                  fontSize: screenWidth * 0.05,
                                  fontFamily: Poppins,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.none
                                  // height: 1.00,
                                ),),
                                SizedBox(
                                  height: screenHeight *0.008,
                                ),

                                Text(DateFormat('EEEE, h:mm a').format(event.eventStartDate) +' - ' + DateFormat('h:mm a').format(event.eventEndDate),
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                // textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: fontGrey,
                                  fontSize: screenWidth * 0.04,
                                  fontFamily: Poppins,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.none
                                  // height: 1.00,
                                ),),
                              ]),
                            )
                          ],),
                          SizedBox(
                              height: screenHeight*0.01,
                            ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Container(
                              width: screenWidth * 0.15,
                              height: screenWidth * 0.15,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(239, 227, 220, 220),
                                 borderRadius: BorderRadius.all(Radius.circular(15)),

                              ),
                              child: Icon(Icons.calendar_month,
                              color: themeColor,
                              size: screenWidth *0.08,),
                            ),
                            SizedBox(
                              width: screenWidth*0.05,
                            ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Text(event.location,
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                // textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: blackText,
                                  fontSize: screenWidth * 0.05,
                                  fontFamily: Poppins,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.none
                                  // height: 1.00,
                                ),),
                                SizedBox(
                                  height: screenHeight *0.008,
                                ),

                                Text(event.location,
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                // textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: fontGrey,
                                  fontSize: screenWidth * 0.04,
                                  fontFamily: Poppins,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.none
                                  // height: 1.00,
                                ),),
                              ]),
                            )
                          ],),
                           SizedBox(
                                  height: screenHeight *0.017,
                                ),

                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                            Container(
                              width: screenWidth * 0.15,
                              height: screenWidth * 0.15,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(239, 227, 220, 220),
                                 borderRadius: BorderRadius.all(Radius.circular(15)),

                              ),
                             child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: CachedNetworkImage(
                                  imageUrl: event.organizerId.profilePicture,
                                  errorWidget: (context, url, error) => Image.asset(event.thumbnail),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   width: screenWidth*0.02,
                            // ),
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Text(event.organizerId.name,
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                // textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: blackText,
                                  fontSize: screenWidth * 0.05,
                                  fontFamily: Poppins,
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.none
                                  // height: 1.00,
                                ),),
                                SizedBox(
                                  height: screenHeight *0.008,
                                ),

                                Text(event.organizerId.contactEmail,
                                maxLines: 1,
                                softWrap: false,
                                overflow: TextOverflow.ellipsis,
                                // textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: fontGrey,
                                  fontSize: screenWidth * 0.04,
                                  fontFamily: Poppins,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.none
                                  // height: 1.00,
                                ),),
                              ]),
                            ),
                            SizedBox(
                              width: screenWidth*0.25,
                            ),
                            //  Container(
                            //   width: screenWidth * 0.15,
                            //   height: screenWidth * 0.15,
                            //   decoration: BoxDecoration(
                            //     color: Color.fromARGB(239, 227, 220, 220),
                            //      borderRadius: BorderRadius.all(Radius.circular(15)),

                            //   ),
                            //   child: Icon(Icons.calendar_month,
                            //   color: themeColor,
                            //   size: screenWidth *0.08,),
                            // ),

                          ],),
                          // Row(children: [],),
                          SizedBox(
                                  height: screenHeight *0.01,
                                ),
                          Row(children: [Container(
                            child: Text("About Event",
                            style: TextStyle(
                                  color: blackText,
                                  fontSize: screenWidth * 0.06,
                                  fontFamily: Poppins,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.none)
                            ),)],),
                             SizedBox(
                                  height: screenHeight *0.01,
                                ),

                            Row(children: [Expanded(
                              child: Container(
                                color: whitishBackground,
                                height: screenHeight *0.171,
                              child: SingleChildScrollView(
                                child: Text(event.description,
                                style: TextStyle(
                                      color: fontGrey,
                                      fontSize: screenWidth * 0.055,
                                      fontFamily: Poppins,
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.none),
                                      softWrap: true,
                                ),
                              ),
                              
                              ),
                            )
                            ],),
                        

                        ],

                      ),
                    )
                  //   Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //     children: [Text("event.isStreaming as String"), const Text("invite")],
                  //   ),
                  //   Text(event.name),
                  //   Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //       children: [
                  //         Icon(Icons.calendar_today), 
                  //       Text("event end date")]),
                  //   Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //       children: [
                  //         Icon(Icons.location_on), 
                  //       Text("start data")]),
                  //   Text(event.description),
                  //    CustomIconButton(labelText: 'Buy', icon: Icon(Icons.arrow_forward),
                  //   onPressed: () => Navigator.pushNamed(context, PaymentPage.routeName, arguments: event),)
                  ],
                ),
              );

            }),
          ],
        ),
      ),

      Positioned(
            top: screenHeight * 0.355, // Adjust the top position as needed
            left: screenWidth *0.1, // Adjust the left position as needed
            right: screenWidth *0.1, // Adjust the right position as needed
            height: screenHeight * 0.08, // Adjust the height as needed

            
            child: Container(
              padding: EdgeInsets.fromLTRB(screenWidth * 0.06, 0, screenWidth * 0.04, 0),
              decoration:  const BoxDecoration(
                color: whitishBackground,
                      borderRadius: BorderRadius.all(Radius.circular(35)),
                       boxShadow: [
                      BoxShadow(
                        color: fontGrey, // Shadow color
                        offset: Offset(0, 0), // Offset from the top
                        blurRadius: 10, // Spread or blur radius
                      ),
                        ],
                      ),

            child: Row(
              
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SizedBox(width: screenWidth * 0.0002,),
                  Text(
                      "+20 Going",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: themeColor,
                        fontSize: screenWidth * 0.055,
                        fontFamily: Poppins,
                        fontWeight: FontWeight.w500,
                      ),),
                TextButton(
                  onPressed: ()=>{}, 
                  child: Container(
                    height: screenHeight * 0.045,
                    width: screenWidth * 0.2,
                    alignment: Alignment.center,
                    decoration:  const BoxDecoration(
                color: themeColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                    child: Text(
                      "invite",
                      style: TextStyle(
                        color: whitishBackground, 
                        fontSize: screenWidth * 0.05),
                      // textAlign: TextAlign.center,
                      )),
                )
              ],
            ),
                 
            ),
          ),

          Positioned(
            top: screenHeight * 0.9, // Adjust the top position as needed
            left: screenWidth *0.06, // Adjust the left position as needed
            right: screenWidth *0.06, // Adjust the right position as needed
            height: screenHeight * 0.085, // Adjust the height as needed
            // child: Container(
              child:CustomButtonAuth(
                labelText: "Buy ticket for \$${event.price ?? ''}",
 
                icon: Icon(Icons.arrow_forward),
                onPressed: () => Navigator.pushNamed(context, PaymentPage.routeName, arguments: event),
                )
    
          ),

      ]
    );
  }

  Widget loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
