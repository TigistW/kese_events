
import 'package:flutter/material.dart';
import 'package:kese_events/core/utils/constants.dart';
import 'package:kese_events/core/utils/fonts.dart';

class OtpText extends StatelessWidget {
  final String type;
  const OtpText({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(
          left: screenWidth * 0.1,
          right: screenWidth * 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Verification",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w700, fontFamily: Poppins),
          ),
          SizedBox(height: screenHeight * 0.02),
          Text.rich(
            TextSpan(
              style: smallTextStyle, //apply style to all
              children: [
                TextSpan(
                  text: 'We have sent a 4 digit OTP verification code to your email at ',
                ),
                TextSpan(
                  text: '$type',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(
                  text: ', Enter the code below.',
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
