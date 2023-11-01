// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Search404 extends StatelessWidget {
  final target, onClicked;

  const Search404({
    Key? key,
    required this.target,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;

    return Container(
      margin: EdgeInsets.fromLTRB(0, height * .04, 0, 0),
      child: Column(
        children: [
          Text(
            "Oops",
            style: TextStyle(
              color: errorTextColor,
              fontWeight: FontWeight.w600,
              fontSize: height * .055,
            ),
          ),
          SizedBox(
            height: height * .01,
          ),
          Text(
            "We couldn't find any resources " +
                (target is String ? "\n realated to $target" : ""),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: errorTextColor,
              fontSize: height * .025,
              fontWeight: FontWeight.w400,
            ),
          ),
          SvgPicture.asset(
            "assets/images/404.svg",
            height: height * .4,
          ),
          GestureDetector(
            onTap: onClicked,
            child: Container(
              // width: width * .35,
              alignment: Alignment.center,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: resourcesIconColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(3),
                ),
              ),
              constraints: BoxConstraints(
                maxWidth: 150,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/home.svg",
                    height: height * .04 / 2,
                  ),
                  SizedBox(
                    width: min(width * .02, 10),
                  ),
                  Text(
                    "Go to Home",
                    style: TextStyle(
                      color: headerBackground,
                      fontWeight: FontWeight.w500,
                      fontSize: height * .02,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
