import 'package:flutter/material.dart';
import 'package:kese_events/core/shared_widgets/loading_widget.dart';

class EventLoadingCard extends StatelessWidget {
  const EventLoadingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        LoadingWidget.rectangular(
          width: screenWidth * 0.65,
          height: screenHeight * 0.25,
          padding: EdgeInsets.all(screenWidth * 0.02),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            LoadingWidget.rectangular(
                width: screenWidth * 0.4,
                height: screenHeight * 0.025,
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.03,
                    vertical: screenWidth * 0.006)),
            LoadingWidget.rectangular(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03,
                  vertical: screenWidth * 0.006),
              width: screenWidth * 0.65,
              height: screenHeight * 0.025,
            ),
            LoadingWidget.rectangular(
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.03,
                  vertical: screenWidth * 0.006),
              width: screenWidth * 0.65,
              height: screenHeight * 0.025,
            ),
          ],
        )
      ],
    );
  }
}
