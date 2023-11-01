import 'package:flutter/material.dart';
import 'package:kese_events/core/shared_widgets/loading_widget.dart';

class TagLoadingCard extends StatelessWidget {
  const TagLoadingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return 
        LoadingWidget.rectangular(
          width: screenWidth * 0.35,
          height: screenHeight * 0.1,
          padding: EdgeInsets.all(screenWidth * 0.035),
        );}}
        