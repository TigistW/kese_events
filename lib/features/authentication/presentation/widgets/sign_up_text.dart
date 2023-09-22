import 'package:flutter/material.dart';
import 'package:kese_events/core/utils/utils.dart';

class SignupText extends StatelessWidget {
  const SignupText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(
          left: screenWidth * 0.01025641025,
          right: screenWidth * 0.60512820512),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sign up",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
