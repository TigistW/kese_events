// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:kese_events/core/utils/colors.dart';
// import 'package:kese_events/core/utils/icons.dart';

// class TagList extends StatelessWidget {
//   final List<String> tags;

//   TagList({required this.tags});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       scrollDirection: Axis.horizontal,
//       child: Row(
//         children: tags.map((tag) {
//           final random = Random();
//           final colorIndex = random.nextInt(tagColors.length);
//           return Card(
//             color: whitishBackground,
//             child: Container(
//                 // margin: EdgeInsets.fromLTRB(4, 4, 0, 0),
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 10, vertical: 0.0),
//                 decoration: BoxDecoration(
//                   // color: whitishBackground,
                 
//                   borderRadius: BorderRadius.circular(15.0),
//                 ),
//                 child: Row(
//                   children: [
//                      Icon(
//                     tagIcons[tag] ??
//                         Icons.event, // Use tag's icon, default to a generic icon if not found
//                     color: tagColors[colorIndex],
//                     size: 20.0,
//                   ),
//                   // SizedBox(width: 2.0),
          
//                 TextButton(
//                   onPressed: () => {},
//                   child: Text(
//                     tag,
//                     style: const TextStyle(
//                       color: fontGrey,
//                       fontSize: 22,
//                     ),
//                   ),
//                 )
//                 ])
                
//                 ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }


import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kese_events/core/shared_widgets/NoEventWidget.dart';
import 'package:kese_events/core/shared_widgets/event_card.dart';
import 'package:kese_events/core/shared_widgets/event_list_card.dart';
import 'package:kese_events/core/shared_widgets/event_list_loading_card.dart';
import 'package:kese_events/core/shared_widgets/event_loading_card.dart';
import 'package:kese_events/core/shared_widgets/tag_loading_card.dart';
import 'package:kese_events/core/utils/colors.dart';
import 'package:kese_events/core/utils/icons.dart';
import 'package:kese_events/features/event/bloc/filter_by_tag_bloc/filter_by_tag_bloc.dart';
import 'package:kese_events/features/event/bloc/filter_by_tag_bloc/filter_by_tag_event.dart';
import 'package:kese_events/features/event/bloc/filter_by_tag_bloc/filter_by_tag_state.dart';
import 'package:kese_events/features/event/bloc/tag_bloc/tag_bloc.dart';
import 'package:kese_events/features/event/bloc/tag_bloc/tag_event.dart';
import 'package:kese_events/features/event/bloc/tag_bloc/tag_state.dart';
import 'package:kese_events/features/event/bloc/upcoming_event_bloc.dart/upcoming_event_bloc.dart';
import 'package:kese_events/features/event/bloc/upcoming_event_bloc.dart/upcoming_event_event.dart';
import 'package:kese_events/features/event/bloc/upcoming_event_bloc.dart/upcoming_event_state.dart';
import 'package:kese_events/features/event/repository/event_repository.dart';
import 'package:kese_events/features/notification/notification_cubit/notification_cubit.dart';
import 'package:kese_events/injector.dart';
import 'package:kese_events/models/event/event.dart';
import 'package:kese_events/models/tag/tag.dart';



class TagList extends StatelessWidget {

   int firstTag = 0;
  
 final ScrollController scrollController = ScrollController();
  final ScrollController scrollControllerEvent = ScrollController();
  final NotificationCubit notificationCubit =
      DependencyInjector.getNotificationCubit()!;


    void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        // if (scrollController.position.pixels != 0) {
        //    Future.delayed(const Duration(seconds: 1), () {
        //     BlocProvider.of<TagBloc>(context).add(const GetTags());
        //   });

        // }
      }
    });
  }

  void setupScrollControllerEvent(context) {
    scrollControllerEvent.addListener(() {
      if (scrollControllerEvent.position.atEdge) {
        if (scrollControllerEvent.position.pixels != 0) {
          // Future.delayed(const Duration(seconds: 1), () {
          //   BlocProvider.of<FilterByTagBloc>(context)
          //       .add( GetEventsByTags(0));
          // }
          // );
          
        }
        }
      }
    
    );
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    setupScrollControllerEvent(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    // BlocProvider.of<TagBloc>(context).add(const GetTags());
    BlocProvider.of<FilterByTagBloc>(context).add( GetEventsByTags(2));
    // context.read<FilterByTagBloc>().add(const GetEventsByTags());

    return
     Column(
       children: [
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
                padding:EdgeInsets.only(left:screenWidth *0.035),
                scrollDirection: Axis.horizontal,
                // controller: scrollController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  if (index < tags.length) {
                    if (firstTag == 0){
                      firstTag =  tags[0].id;
                    }
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
                            child: Row(
                              children: [
                                Icon(
                                tagIcons[tags[index]] ??
                                    Icons.event, // Use tag's icon, default to a generic icon if not found
                                color: tagColors[colorIndex],
                                size: 20.0,
                              ),
                              // SizedBox(width: 2.0),
                      
                            TextButton(
                              onPressed: () => {context.read<FilterByTagBloc>().add(GetEventsByTags(tags[index].id))},
                            child: Text(
                              tags[index].name,
                              style: const TextStyle(
                                color: fontGrey,
                                fontSize: 22,
                              ),
                            ),
                          )
                          ])
                      
                      ),
                );
                  // } else {
                  //   Timer(const Duration(milliseconds: 30), () {
                  //     scrollController
                  //         .jumpTo(scrollController.position.maxScrollExtent);
                  //   });
                  //   return loadingIndicatorTag();
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
          height: screenHeight * 0.245,
          child: BlocBuilder<FilterByTagBloc, FilterByTagState>(
              builder: (context, state) {
            if (state is FilterByTagLoading) {
              return SizedBox(
                height: screenHeight,
                child: ListView(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: const [
                    EventLoadingListCard(),
                    EventLoadingListCard(),
                    EventLoadingListCard(),
                    EventLoadingListCard(),
                  ],
                ),
              );
            }
        
            List<Event> events = [];
            if (state is FilterByTagLoading) {
              events = state.events;
            } else if (state is FilterByTagSuccess) {
              events = state.events;
            } 
        
            return Container(
              height: screenHeight * 0.35,
              padding: EdgeInsets.only(
                  left: screenWidth * 0.03153846153,
                  right: screenWidth * 0.03076923076,
                  // top: screenHeight * 0.000125
                  ),
              child: ListView.builder(
                  // controller: scrollControllerEvent,
                  itemCount: events.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (events.length == 0){
                      return NoEventsWidget(
                        message:
                            "Looks like there is no events with that tag, Come back later!",
                      );

                    }
                    if (index < events.length) {
                      return EventListCard(
                        data: events[index],
                      );
                    }else{
                       Timer(const Duration(milliseconds: 30), () {
                        scrollController
                            .jumpTo(scrollController.position.maxScrollExtent);
                      });
                    }
                    if (state is FilterByTagFailure) {
                      return NoEventsWidget(
                        message:
                            "Looks like there is no events, Come back later!",
                      );
                    }
                    // if (state is FilterByTagNoNewData) {
                    //   return Center(
                    //     child: Container(
                    //       child: Column(children: [
                    //         InkWell(
                    //           onTap: () {
                    //             context
                    //                 .read<FilterByTagBloc>()
                    //                 .add(GetEventsByTags(0));
                    //           },
                    //           child: const Icon(
                    //             Icons.replay_outlined,
                    //             color: Color.fromARGB(255, 115, 133, 117),
                    //           ),
                    //         ),
                    //         Text(
                    //           state.message,
                    //           style: const TextStyle(
                    //             color: Color.fromARGB(255, 115, 133, 117),
                    //           ),
                    //         ),
                    //       ]),
                    //     ),
                    //   );
                    // }
             
                   
                    // Timer(Duration(milliseconds: 30), () {
                    //   scrollControllerEvent.position
                    //       .jumpTo(scrollControllerEvent.position.maxScrollExtent);
                    // });
        
                    // return loadingIndicator();
                  }),
            );
          }
              
          ),
        ),
      ],
     );
  }

  Widget loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }

    Widget loadingIndicatorTag() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

