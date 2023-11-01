// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:kese_events/core/shared_widgets/event_card.dart';
// import 'package:kese_events/core/shared_widgets/event_list_card.dart';
// import 'package:kese_events/core/utils/colors.dart';
// import 'package:kese_events/features/event/bloc/event_detail_bloc/event_detail_bloc.dart';
// import 'package:kese_events/features/event/bloc/event_detail_bloc/event_detail_event.dart';
// import 'package:kese_events/features/event/bloc/event_detail_bloc/event_detail_state.dart';
// import 'package:kese_events/features/notification/notification_cubit/notification_cubit.dart';
// import 'package:kese_events/features/payment/bloc/payment/payment_bloc.dart';
// import 'package:kese_events/features/payment/bloc/payment/payment_state.dart';
// import 'package:kese_events/features/payment/presentation/widgets/payment_content.dart';
// import 'package:kese_events/injector.dart';
// import 'package:kese_events/models/event/event.dart';
// import 'package:kese_events/models/user/organizer.dart';

// class PaymentPage extends StatefulWidget {
//   static const String routeName = "/paymentpage";
//   final Event event;
//   PaymentPage({
//     Key? key, required this.event,
//   }) : super(key: key);

//   @override
//   State<PaymentPage> createState() => _PaymentPageState();
// }

// class _PaymentPageState extends State<PaymentPage> {
//   // final scrollController = ScrollController();
//   final NotificationCubit notificationCubit = DependencyInjector.getNotificationCubit()!;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//     BlocProvider.of<EventDetailBloc>(context).add(GetEventDetail(widget.event.id));
//     BlocProvider.of<PaymentBloc>(context).add();
//     return Container(
//       color: whitishBackground,
//       child: Column(
//         children: [
//           BlocBuilder<EventDetailBloc, EventDetailState>(
//               builder: (context, state) {
//             if (state is EventDetailLoading) {
//               return loadingIndicator();
//             }

//              Event event = Event(
//                 createdDate: "createdDate",
//                 updatedDate: "updatedDate",
//                 id: 1,
//                 name: "name",
//                 description: "description",
//                 eventEndDate: "eventDate",
//                 eventStartDate: "eventTime",
//                 price: 123456,
//                 thumbnail: "thumbnail",
//                 organizerId: Organizer(
//                   id: 1,
//                    name: "name",
//                    profilePicture: "profilePicture", 
//                    website: "website", 
//                    contactEmail: "contactEmail", 
//                    description: "description"
//                    ), tags: [], location: '', capacity: 12);

//             bool isLoading = false;
    
//             if (state is EventDetailFailure) {
//               print(state.msg);
//               notificationCubit.errorNotification(message: state.msg);
//             } 
//               if (state is EventDetailFailure) {
//                 notificationCubit.errorNotification(message: state.msg);
//                }


//           print(state);
//             if (state is EventDetailSuccess) {
//               event = state.event;
//             }
//             print("event found in detail");
//             print(event.name);
//             return Container(
//               height: screenHeight * 0.8,
//               child: Column(
//                 children: [
//                   EventListCard(data: event),

//           // BlocBuilder<PaymentBloc, PaymentState>(
//           //     builder: (context, state) {
//           //       return Container(color: themeColor,);
//           //     })
          
            
                  
//                 ],
//               ),
//             );
//           }
//           ),
//           PaymentContent(event: event)
//         ],
//       ),
//     );
//   }

//   Widget loadingIndicator() {
//     return const Padding(
//       padding: EdgeInsets.all(8.0),
//       child: Center(child: CircularProgressIndicator()),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kese_events/core/shared_widgets/event_list_card.dart';
import 'package:kese_events/core/utils/colors.dart';
import 'package:kese_events/features/authentication/bloc/sign_in_bloc/index.dart';
import 'package:kese_events/features/event/bloc/event_detail_bloc/event_detail_bloc.dart';
import 'package:kese_events/features/event/bloc/event_detail_bloc/event_detail_state.dart';
import 'package:kese_events/features/notification/notification_cubit/notification_cubit.dart';
import 'package:kese_events/features/payment/bloc/payment/payment_bloc.dart';
import 'package:kese_events/features/payment/presentation/widgets/payment_content.dart';
import 'package:kese_events/injector.dart';
import 'package:kese_events/models/event/event.dart';
import 'package:kese_events/models/user/organizer.dart';

class PaymentPage extends StatefulWidget{
    final Event event;
    static const String routeName = "/payment_page";

      const PaymentPage({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}
    

class _PaymentPageState extends State<PaymentPage>{
  final NotificationCubit notificationCubit = DependencyInjector.getNotificationCubit()!;
      @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    Event event = Event(
                  createdDate: "createdDate",
                  updatedDate: "updatedDate",
                  id: 1,
                  name: "hhhh",
                  description: "description",
                  eventEndDate: DateTime.now(),
                  eventStartDate: DateTime.now(),
                  price: 123,
                  thumbnail: "thumbnail",
                  organizerId: Organizer(
                    id: 1,
                     name: "name",
                     profilePicture: "profilePicture", 
                     website: "website", 
                     contactEmail: "contactEmail", 
                     description: "description"
                     ), tags: [], location: '', capacity: 12);
    BlocProvider(
        create: (context) {
          return PaymentBloc(paymentRepository: DependencyInjector.getPaymentRepository()!,
           userHiveRepository: DependencyInjector.getUserHiveRepository()!,
            eventDetailRepository: DependencyInjector.getEventRepository()!);
        },);

    return  Scaffold(
            body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
        child: Column(children: [
          
          
          Container(
            height: screenHeight *0.1,
            padding: EdgeInsets.only(left: screenWidth*0.05),
            // color: Colors.blueAccent,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              
              children: [
             IconButton(
              icon: Icon(Icons.arrow_back, color: blackText,),
              onPressed: () {
                Navigator.of(context).pop(); // Pop the current page
              },
            ),
            ],
            ),
          ),
          Container(
            width: screenWidth,
            padding: EdgeInsets.only(left: screenWidth*0.09),
            // color: themeColor,
            child: Text("Buy Ticket",
            textAlign: TextAlign.left,
            style:TextStyle(
              color: blackText,
              fontSize: screenWidth *0.08,
              fontWeight: FontWeight.w500,
              
            )
            ),
          ),
        Container(
          // color: themeColor,
          height: screenHeight *0.2,
          child: BlocBuilder<EventDetailBloc, EventDetailState>(
                builder: (context, state) {
              if (state is EventDetailLoading) {
                return loadingIndicator();
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
                // setState(() {
                //   event = state.event;
                // });
              }
              return Container(
                width: screenWidth,
                margin: EdgeInsets.all(screenWidth *0.015),
              child: 
                  EventListCard(data: event),
                  
              );

                }
          )
              
          ),
          Container(
          // color: themeColor,
          height: screenHeight *0.7,
          child: BlocBuilder<EventDetailBloc, EventDetailState>(
                builder: (context, state) {
              if (state is EventDetailLoading) {
                return loadingIndicator();
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
                // setState(() {
                //   event = state.event;
                // });
              }
              return Container(
                width: screenWidth,
                margin: EdgeInsets.all(screenWidth *0.015),
              child: 
                  PaymentContent(event:event),
                  );
                  
              

                }
          )
              
          ),
         
        // Container(
        //   // color: themeColor,
        //   height: screenHeight *0.7,
        //   child: PaymentContent(event:widget.event),
        //   )



      ]),
            ),
          ),
        ),
            ),


      // child: BlocProvider(
      //   create: (context) {
      //     return PaymentBloc(paymentRepository: DependencyInjector.getPaymentRepository()!,
      //      userHiveRepository: DependencyInjector.getUserHiveRepository()!,
      //       eventDetailRepository: DependencyInjector.getEventRepository()!);
      //   },



        // child: LayoutBuilder(
        //   builder: (context, constraints) => SingleChildScrollView(
        //     child: ConstrainedBox(
        //         constraints: BoxConstraints(minHeight: constraints.maxHeight),
        //         child: IntrinsicHeight(
        //           child: Column(
        //               // mainAxisAlignment: MainAxisAlignment.spaceAround,
        //               children: [
        //                 SizedBox(
        //                   height: screenHeight * 0.1,
        //                 ),
        //                 Container(
        //                     color: whitishBackground,
        //                     child: Column(
        //                       children: [
        //                         BlocBuilder<EventDetailBloc, EventDetailState>(
        //                             builder: (context, state) {
        //                           if (state is EventDetailLoading) {
        //                             return loadingIndicator();
        //                           }

        //                           Event event = Event(
        //                               createdDate: "createdDate",
        //                               updatedDate: "updatedDate",
        //                               id: 1,
        //                               name: "name",
        //                               description: "description",
        //                               eventEndDate: DateTime.now(),
        //                               eventStartDate: DateTime.now(),
        //                               price: 123456,
        //                               thumbnail: "thumbnail",
        //                               organizerId: Organizer(
        //                                 id: 1,
        //                                 name: "name",
        //                                 profilePicture: "profilePicture", 
        //                                 website: "website", 
        //                                 contactEmail: "contactEmail", 
        //                                 description: "description"
        //                                 ), tags: [], location: '', capacity: 12);

        //                               bool isLoading = false;
                                  
        //                               if (state is EventDetailFailure) {
        //                                 print(state.msg);
        //                                 notificationCubit.errorNotification(message: state.msg);
        //                               } 
        //                                 if (state is EventDetailFailure) {
        //                                   notificationCubit.errorNotification(message: state.msg);
        //                                 }

        //                             print(state);
        //                             if (state is EventDetailSuccess) {
        //                               event = state.event;
        //                             }
        //                             print("event found in detail");
        //                             print(event.name);
        //                             return Container(
        //                               height: screenHeight * 0.3,
        //                               child: Column(
        //                                 children: [
        //                                   EventListCard(data: event),
                                          
        //                                 ],
        //                               ),
        //                             );
        //                           }
        //                           ),
                                  
        //                           ],
        //                         ),
        //                       ),
        //                 // SizedBox(
        //                 //   height: screenHeight * 0.03,
        //                 // ),
                        // PaymentContent(event: event,),
        //               ]),
        //         )
        //         // ],
        //         ),
        //   ),
        // ),
        // }
        // ),
    
    // )
    );
  }
  Widget loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
// }
}