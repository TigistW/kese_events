// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:kese_events/core/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

class LoadingWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;
  final EdgeInsets padding;
  final double radius;
  final Color backgroundColor;

  LoadingWidget.rectangular({
    this.width = double.infinity,
    this.padding = const EdgeInsets.all(0),
    this.radius = 8.0,
    this.backgroundColor = loadingBaseColor,
    required this.height,
  }) : shapeBorder =
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius));

  LoadingWidget.circular({
    this.width = double.infinity,
    required this.height,
    this.radius = 8.0,
    this.backgroundColor = loadingBaseColor,
    this.padding = const EdgeInsets.all(0),
    this.shapeBorder = const CircleBorder(),
  });

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: backgroundColor,
        highlightColor: loadingHighlightColor,
        period: Duration(seconds: 2),
        direction: ShimmerDirection.ltr,
        child: Padding(
          padding: padding,
          child: Container(
            width: width,
            height: height,
            decoration: ShapeDecoration(
              color: backgroundColor,
              shape: shapeBorder,
            ),
          ),
        ),
      );
}
