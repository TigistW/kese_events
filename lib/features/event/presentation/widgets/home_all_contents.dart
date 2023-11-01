import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kese_events/core/shared_widgets/event_card.dart';
import 'package:kese_events/core/shared_widgets/event_loading_card.dart';
import 'package:kese_events/core/utils/colors.dart';
import 'package:kese_events/core/utils/fonts.dart';
import 'package:kese_events/features/event/bloc/event_bloc/event_bloc.dart';
import 'package:kese_events/features/event/bloc/event_bloc/event_event.dart';
import 'package:kese_events/features/event/bloc/event_bloc/event_state.dart';
import 'package:kese_events/features/event/bloc/upcoming_event_bloc.dart/upcoming_event_bloc.dart';
import 'package:kese_events/features/event/bloc/upcoming_event_bloc.dart/upcoming_event_event.dart';
import 'package:kese_events/features/event/bloc/upcoming_event_bloc.dart/upcoming_event_state.dart';
import 'package:kese_events/features/event/presentation/widgets/event_list_content.dart';
import 'package:kese_events/features/event/presentation/widgets/home_content.dart';
import 'package:kese_events/features/event/presentation/widgets/tag_list.dart';
import 'package:kese_events/features/notification/notification_cubit/notification_cubit.dart';
import 'package:kese_events/injector.dart';
import 'package:kese_events/models/event/event.dart';


class AllHomeContents extends StatelessWidget {
  
  final NotificationCubit notificationCubit =
      DependencyInjector.getNotificationCubit()!;


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child:   Column(
        children:[
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            Text(
              "Upcoming Events", 
              style: TextStyle(
                fontSize: screenWidth * 0.07,
                fontFamily: Poppins,
                color: blackText, 
                fontWeight: FontWeight.w700),
            ), 
            Row(
              children: [
                TextButton(
                  onPressed: () => {},
                  child: 
                  Text(
                  "See All",
                  style: TextStyle(
                          fontSize: screenWidth * 0.06, 
                          fontFamily: Poppins,
                          color: fontGrey),
                    )
                  ),
                  Icon(Icons.arrow_right, 
                  size: screenWidth * 0.07,
                  color: fontGrey,)
              ],
            )],
        ),
        HomeContent(),
        TagList(),

        ]
         
      ),
    );
  }
}
