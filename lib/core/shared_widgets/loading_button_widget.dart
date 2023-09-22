import 'package:flutter/material.dart';

Widget getLoadingWidget(screenHeight, screenWidth, Color color) {
  return Container(
    margin: EdgeInsets.only(top: screenHeight * 1 / 120),
    alignment: Alignment.centerRight,
    height: screenHeight * 1 / 20,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: color,
      ),
      child: Container(
        width: screenWidth * 1 / 8.3,
        alignment: Alignment.center,
        child: const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 3,
          ),
        ),
      ),
      onPressed: () {},
    ),
  );
}
