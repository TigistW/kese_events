
import 'package:flutter/material.dart';
import 'package:kese_events/core/utils/colors.dart';

class CustomIconButton extends StatelessWidget {
  final String labelText;
  final Icon icon;
  final VoidCallback? onPressed;
  const CustomIconButton(
      {Key? key, required this.labelText, required this.icon, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: themeColor,
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Text(labelText),
          icon,
        ]),
        onPressed: onPressed,
      ),
    );
  }
}
