import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kese_events/core/shared_widgets/NoEventWidget.dart';
import 'package:kese_events/core/shared_widgets/event_list_card.dart';
import 'package:kese_events/core/shared_widgets/event_list_loading_card.dart';
import 'package:kese_events/core/shared_widgets/filter_button.dart';
import 'package:kese_events/core/shared_widgets/tag_loading_card.dart';
import 'package:kese_events/core/utils/colors.dart';
import 'package:kese_events/core/utils/fonts.dart';
import 'package:kese_events/core/utils/icons.dart';
import 'package:kese_events/features/event/bloc/event_bloc/event_bloc.dart';
import 'package:kese_events/features/event/bloc/event_bloc/event_event.dart';
import 'package:kese_events/features/event/bloc/event_bloc/event_state.dart';
import 'package:kese_events/features/event/bloc/filter_by_tag_bloc/filter_by_tag_bloc.dart';
import 'package:kese_events/features/event/bloc/filter_by_tag_bloc/filter_by_tag_event.dart';
import 'package:kese_events/features/event/bloc/tag_bloc/tag_bloc.dart';
import 'package:kese_events/features/event/bloc/tag_bloc/tag_event.dart';
import 'package:kese_events/features/event/bloc/tag_bloc/tag_state.dart';
import 'package:kese_events/features/event/presentation/widgets/events_text.dart';
import 'package:kese_events/features/notification/notification_cubit/notification_cubit.dart';
import 'package:kese_events/injector.dart';
import 'package:kese_events/models/event/event.dart';
import 'package:kese_events/models/tag/tag.dart';
import 'package:lottie/lottie.dart';

class EventListContent extends StatefulWidget {
  @override
  _EventListContentState createState() => _EventListContentState();
}

class _EventListContentState extends State<EventListContent> {


// class EventListContent extends StatelessWidget {
  static const String routeName = "/event_list_page";
  // EventListContent({Key? key,}) : super(key: key);
    
  bool reachedLastEvent = false;
  bool isFormVisible = false;
  final ScrollController scrollController = ScrollController();
  final ScrollController scrollControllerEvent = ScrollController();
  final NotificationCubit notificationCubit =
      DependencyInjector.getNotificationCubit()!;

  // void setupScrollController(BuildContext context) {
  //   scrollController.addListener(() {
  //     if (scrollController.position.atEdge) {
  //       if (scrollController.position.pixels != 0) {
  //         Future.delayed(const Duration(milliseconds: 30), () {
  //             context.read<TagBloc>().add(const GetTags());
  //           });
  //         }
  //       }
    
  //   });
  // }

  // void setupScrollControllerEvent(BuildContext context) {
  //   scrollControllerEvent.addListener(() {
  //     if (scrollControllerEvent.position.atEdge) {
  //       if (scrollControllerEvent.position.pixels != 0) {
  //         Future.delayed(const Duration(milliseconds: 2000), () {
  //           context.read<EventBloc>().add(const GetEvents());
  //         });
  //       }
  //     }
  //   });
  // }

  void toggleFormVisibility() {
        setState(() {
          print("jjjjjjjjjjjjjjjj");
          isFormVisible = !isFormVisible;
        });
      }

  @override
  Widget build(BuildContext context) {
    // setupScrollController(context);
    // setupScrollControllerEvent(context);
    BlocProvider.of<TagBloc>(context).add(const GetTags());
    context.read<EventBloc>().add(const GetEvents());

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            SizedBox(
                      height: screenHeight * 0.012,
                    ),
            Container(
              // color: themeColor,
              // padding: EdgeInsets.only(
              //           left: screenWidth * 0.01,
              //           right: screenWidth * 0.01
              //         ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                    
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop(); // Pop the current page
                      },
                    ),
            
                   
                 EventsText(msg: "Events",
                 color: blackText,),
                 SizedBox(
                        width: screenWidth * 0.02,
                      ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: toggleFormVisibility,
                ),]),),
                
                if (isFormVisible) // Display the text field and button if isFormVisible is true
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(width: screenWidth * 0.045),
                           
                            Container(
                              
                              decoration: BoxDecoration(
                                  color: Colors.grey, // Set the background color to grey
                                  borderRadius: BorderRadius.circular(20.0), // Adjust the radius as needed
                                ),
                              width: screenWidth * 0.7,
                              height: screenHeight * 0.05,
                              child: TextFormField(
                                textAlign : TextAlign.left,
                                style: TextStyle(color: blackText),
                                decoration: InputDecoration(
                                  hintText: 'Search',
                                  hintStyle:
                                      TextStyle(
                                        color: fontGrey,fontFamily: Poppins,fontSize: 21, 
                                        ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(left: screenWidth * 0.06),
                                ),), ),
                                 IconButton(
                                  icon: const Icon(
                                    Icons.send,
                                    color: blackText,
                                    size: 25,
                                  ),
                                  onPressed: ()=>{},  
                                ),
                                SizedBox(width: screenWidth * 0.038),    
                                ] ),
              ],
              ),
            ),
            SizedBox(height: screenHeight * 0.03),  
             Container(
              height: screenHeight * 0.06,
               child: BlocBuilder<TagBloc, TagState>(builder: (context, state) {
                if (state is TagLoading) {
                  return SizedBox(
                    height: screenHeight * 0.06,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: const [
                        TagLoadingCard(),
                        TagLoadingCard(),
                        TagLoadingCard(),
                        TagLoadingCard()
                      ],
                    ),
                  );
                }
             
                List<Tag> tags = [];
                bool isLoading = false;
             
                if (state is TagLoading) {
                  tags = state.tags;
                  isLoading = true;
                } else if (state is TagSuccess) {
                  tags = state.tags;
                }
             
                if (state is TagFailure) {
                  notificationCubit.errorNotification(message: state.msg);
                }
             
                if (state is TagFailure) {
                  notificationCubit.errorNotification(message: state.msg);
                }
             
                return Container(
                  
                  height: screenHeight * 0.06,
                  child: ListView.separated(
                    padding: EdgeInsets.only(left: screenWidth * 0.035),
                    scrollDirection: Axis.horizontal,
                    // controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index < tags.length) {
                        final random = Random();
                        final colorIndex = random.nextInt(tagColors.length);
                        return Card(
                          color: whitishBackground,
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 0.0),
                              decoration: BoxDecoration(
                                // color: whitishBackground,
             
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Row(children: [
                                Icon(
                                  tagIcons[tags[index]] ??
                                      Icons
                                          .event, // Use tag's icon, default to a generic icon if not found
                                  color: tagColors[colorIndex],
                                  size: 20.0,
                                ),
                                // SizedBox(width: 2.0),
             
                                TextButton(
                                  onPressed: () => {
                                    context
                                        .read<FilterByTagBloc>()
                                        .add(GetEventsByTags(tags[index].id))
                                  },
                                  child: Text(
                                    tags[index].name,
                                    style: const TextStyle(
                                      color: fontGrey,
                                      fontSize: 22,
                                    ),
                                  ),
                                )
                              ])),
                        );
                      } else {
                        Timer(const Duration(milliseconds: 30), () {
                          scrollController
                              .jumpTo(scrollController.position.maxScrollExtent);
                        });
             
                        return loadingIndicator();
                      }
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: Colors.black,
                      );
                    },
                    itemCount: tags.length + (isLoading ? 1 : 0),
                  ),
                );
                       }),
             ),
    
            Container(
             height: isFormVisible ? screenHeight * 0.686 : screenHeight * 0.742,
              child: BlocBuilder<EventBloc, EventState>(
                builder: (context, state) {
                  if (state is EventLoading && state.isFirstFetch) {
                     return SizedBox(
                    height: screenHeight * 0.75,
                    child: ListView(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      children: const [
                        EventLoadingListCard(),
                        EventLoadingListCard(),
                        EventLoadingListCard(),
                        EventLoadingListCard(),
                        EventLoadingListCard()
                      ],
                    ),
                  );
                  }
            
                  List<Event> events = [];
                  if (state is EventLoading) {
                    events = state.events;
                  } else if (state is EventSuccess) {
                    events = state.events;
                  } 
                  // else if (state is EventNoNewData) {
                  //   events = state.events;
                  //   reachedLastEvent = true;
                  // }
            
                  return Container(
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.03153846153,
                        right: screenWidth * 0.03076923076,
                        top: screenHeight * 0.0125),
                    child: ListView.builder(
                        // controller: scrollControllerEvent,
                        itemCount: events.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index < events.length) {
                              return EventListCard(
                                data: events[index],
                              );
                            }else {
                              Timer(const Duration(milliseconds: 30), () {
                                scrollControllerEvent
                                    .jumpTo(scrollControllerEvent.position.maxScrollExtent);
                              });}
                          if (state is EventFailure) {
                            return NoEventsWidget(
                              message:
                                  "Looks like there is no events, Come back later!",
                            );
                          }
            
                          return Container(
                              height: screenHeight * 0.1,
                              child: Lottie.asset(
                                'assets/lottie/loading_lottie.json',
                                width: screenHeight * 0.3,
                                height: screenHeight * 0.3,
                                repeat: true, // Set to true to loop the animation
                              ),
                        );
                        }
                            ),
                          );
                        }),
            ),
          ],
        ),
            ),
    );
      //   },
      // ),
    // );
  }

 Widget loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator()
        ),
    );
  }
}
