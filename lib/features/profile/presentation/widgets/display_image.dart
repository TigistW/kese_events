import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kese_events/core/utils/colors.dart';
import 'package:kese_events/core/utils/icons.dart';

class DisplayImage extends StatelessWidget {
  final String imagePath;
  final bool hasEditIcon;
  final VoidCallback onPressed;

  // Constructor
  const DisplayImage({
    Key? key,
    required this.imagePath,
    required this.hasEditIcon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = themeColor;
    final screenHeight = MediaQuery.of(context).size.height;
    return Center(
        child: Stack(children: [
      buildImage(color, screenHeight),
      if (hasEditIcon)
        Positioned(
          child: buildEditIcon(color, onPressed),
          right: 5,
          bottom: 6,
        )
    ]));
  }

  // Builds Profile Image
  Widget buildImage(Color color, screenHeight) {
    final image = imagePath.contains('https://')
        ? NetworkImage(imagePath)
        : FileImage(File(imagePath), scale: 4);
    return CircleAvatar(
      radius: screenHeight * 0.08125,
      backgroundColor: color,
      child: CircleAvatar(
        backgroundImage: image as ImageProvider,
        radius: screenHeight * 0.081,
      ),
    );
  }

  // Builds Edit Icon on Profile Picture
  Widget buildEditIcon(Color color, onPressed) =>
      buildCircle(all: 5, child: profileEditIcon, onPressed: onPressed);

  // Builds/Makes Circle for Edit Icon on Profile Picture
  Widget buildCircle({
    required Widget child,
    required double all,
    required onPressed,
  }) =>
      GestureDetector(
        onTap: onPressed,
        child: ClipOval(
          child: Container(
            padding: EdgeInsets.all(all),
            color: themeColor,
            child: child,
          ),
        ),
      );
}
