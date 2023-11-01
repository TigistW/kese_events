import 'package:flutter/material.dart';
import 'package:kese_events/core/shared_widgets/loading_widget.dart';
import 'package:kese_events/core/utils/colors.dart';

class EventLoadingListCard extends StatelessWidget {
  const EventLoadingListCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(top: screenHeight * 0.02),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          LoadingWidget.rectangular(
            width: screenWidth * 0.3,
            height: screenHeight * 0.15,
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.0005, horizontal: screenWidth * 0.03),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              LoadingWidget.rectangular(
                  width: screenWidth * 0.4,
                  height: screenHeight * 0.03,
                  padding: EdgeInsets.only(top:screenHeight * 0.02)
                      ),
              LoadingWidget.rectangular(
                padding: EdgeInsets.only(top:screenHeight * 0.015),
                width: screenWidth * 0.6,
                height: screenHeight * 0.03,
              ),
               LoadingWidget.rectangular(
                padding: EdgeInsets.only(top:screenHeight * 0.015),
                width: screenWidth * 0.6,
                height: screenHeight * 0.03,
              ),
            ],
          )
        ],
      ),
    );
  }
}
