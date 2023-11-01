import 'package:flutter/material.dart';
import 'package:kese_events/core/utils/utils.dart';

class EventsText extends StatelessWidget {
  final String msg;
  final Color color;
  const EventsText({Key? key, required this.msg, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      
      padding: EdgeInsets.only(
          left: screenWidth * 0.01025641025,
          right: screenWidth * 0.40512820512),
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            msg,
            style: TextStyle(
              color: color,
                fontFamily: Poppins, fontSize: screenWidth * 0.085, fontWeight: FontWeight.w400,decoration: TextDecoration.none),
          ),
        ],
      ),
    );
  }
}
