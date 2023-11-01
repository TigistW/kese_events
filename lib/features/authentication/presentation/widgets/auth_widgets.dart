import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kese_events/core/utils/utils.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SvgPicture.string(logo, height: screenHeight * 0.05625),
      ]),
    );
  }
}

class LogoName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SvgPicture.string(logoName, height: screenHeight * 0.05625),
      ]),
    );
  }
}

class SplashPageLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, 
        children: [
        SvgPicture.string(logoName, height: screenHeight * 0.07625),
      ]),
    );
  }
}

