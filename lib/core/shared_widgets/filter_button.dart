import 'package:flutter/material.dart';
import 'package:kese_events/core/utils/colors.dart';
import 'package:kese_events/core/utils/fonts.dart';

class FilterButton extends StatelessWidget {
  VoidCallback? onPressed;

  FilterButton({
    Key? key,
    this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      ),
      onPressed: onPressed, 
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          InkWell(
            onTap: onPressed,
            child: Container(
              width: screenHeight * 0.03, 
              height: screenHeight * 0.03,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: themeColor,
              ),
              child: Center(
                child: Icon(
                  Icons.filter_list,
                  color: Colors.white, 
                ),
              ),
            ),
          ), 
        SizedBox(width: screenWidth * 0.02),
              Text(
                "Filter", 
              style: TextStyle(
                fontSize: 17,
                color: blackText,
                fontFamily: Poppins
              ),)

            ]),
          ));
    
    }}