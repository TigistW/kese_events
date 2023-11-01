import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NoEventsWidget extends StatelessWidget {
  String message;
  NoEventsWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(top: screenHeight * (70 / 844)),
        child: Column(children: [
          Text(
            "Oops",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 30,
              color: Color.fromRGBO(32, 68, 40, 1),
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(
            height: screenHeight * (16 / 844),
          ),
          Text(
            message,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: Color.fromRGBO(32, 68, 40, 1),
              fontFamily: 'Poppins',
            ),
          ),
          SizedBox(
            height: screenHeight * (16 / 844),
          ),
          SvgPicture.asset(
            'assets/images/cuate.svg',
            height: screenHeight * (300 / 844),
          ),
          SizedBox(
            height: 100,
          )
        ]),
      ),
    );
  }
}
