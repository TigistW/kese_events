
import 'package:flutter/material.dart';
import 'package:kese_events/core/shared_widgets/shared_widgets.dart';

import '../utils/utils.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.hintText,
      required this.prefixIcon,
      this.validator,
      this.onChanged,
      this.inputType = TextInputType.text,
      this.initialValue})
      : super(key: key);

  final String hintText;
  final Icon prefixIcon;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;
  final TextInputType inputType;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // const SizedBox(
        //   height: 1.0,
        // ),
        CustomTextFormField(
          validator: validator,
          keyboardType: inputType,
          onChanged: onChanged,
          initialValue: initialValue,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            border: InputBorder.none,
            filled: true,
            fillColor: backgroundGrey,
            hoverColor: backgroundGrey,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(5)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 0.0),
            hintText: hintText,
            hintStyle: const TextStyle(color: fontGrey),
          ),
          style: const TextStyle(
            color: fontGrey,
            fontWeight: FontWeight.w300,
            fontSize: 14,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    );
  }
}
