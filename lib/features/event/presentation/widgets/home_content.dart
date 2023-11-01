import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kese_events/core/shared_widgets/event_card.dart';
import 'package:kese_events/core/shared_widgets/event_loading_card.dart';
import 'package:kese_events/core/utils/colors.dart';
import 'package:kese_events/features/event/bloc/event_bloc/event_bloc.dart';
import 'package:kese_events/features/event/bloc/event_bloc/event_event.dart';
import 'package:kese_events/features/event/bloc/event_bloc/event_state.dart';
import 'package:kese_events/features/event/bloc/upcoming_event_bloc.dart/upcoming_event_bloc.dart';
import 'package:kese_events/features/event/bloc/upcoming_event_bloc.dart/upcoming_event_event.dart';
import 'package:kese_events/features/event/bloc/upcoming_event_bloc.dart/upcoming_event_state.dart';
import 'package:kese_events/features/notification/notification_cubit/notification_cubit.dart';
import 'package:kese_events/injector.dart';
import 'package:kese_events/models/event/event.dart';


class HomeContent extends StatefulWidget{
  const HomeContent({super.key});
  
  @override
  State<StatefulWidget> createState() => _HomeContentState();
  
}

class _HomeContentState extends State<HomeContent> {

  final scrollController = ScrollController();
  final NotificationCubit notificationCubit =
      DependencyInjector.getNotificationCubit()!;


    @override
  void initState() {
    super.initState();
  }


  void setupScrollController(context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          BlocProvider.of<UpcomingEventBloc>(context).add(const GetUpcomingEvents());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    BlocProvider.of<UpcomingEventBloc>(context).add(const GetUpcomingEvents());

    return BlocBuilder<UpcomingEventBloc, UpcomingEventState>(builder: (context, state) {
      if (state is UpcomingEventLoading && state.isFirstFetch) {
        // return loadingIndicator();
        return SizedBox(
          height: screenHeight * 0.389,
          child: ListView(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: const [
              EventLoadingCard(),
              EventLoadingCard(),
              EventLoadingCard()
            ],
          ),
        );
      }

      List<Event> events = [

      ];
      bool isLoading = false;

      if (state is UpcomingEventLoading) {
        events = state.events;
        isLoading = true;
      } else if (state is UpcomingEventSuccess) {
        events = state.events;
      }

      if (state is UpcomingEventFailure) {
        print(state.msg);
        notificationCubit.errorNotification(message: state.msg);
      }

      if (state is UpcomingEventFailure) {
        notificationCubit.errorNotification(message: state.msg);
      }
      return Container(
        
        height: screenHeight * 0.389,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            if (index < events.length) {
              return EventCard(data: events[index]);
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
          itemCount: events.length + (isLoading ? 1 : 0),
        ),
      );
    });
  }

  Widget loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
