
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
            border: OutlineInputBorder(
                borderSide:const BorderSide(color: fontGrey),
                borderRadius: BorderRadius.circular(10)),
            filled: true,
            fillColor: backgroundForTextField,
            hoverColor: backgroundForTextField,
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: fontGrey, width:1),
                borderRadius: BorderRadius.circular(10)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 0.0),
            hintText: hintText,
            hintStyle: const TextStyle(color: fontGrey),
          ),
          style:  TextStyle(
            color: fontGrey,
            fontWeight: FontWeight.w400,
            fontSize: 18,
            fontFamily: Poppins,
          ),
        ),
      ],
    );
  }
}


class CustomNumberField extends StatelessWidget {
  const CustomNumberField(
      {Key? key,
      required this.hintText,
      required this.prefixIcon,
      this.validator,
      this.onChanged,
      this.inputType = TextInputType.number,
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
            border: OutlineInputBorder(
                borderSide:const BorderSide(color: fontGrey),
                borderRadius: BorderRadius.circular(10)),
            filled: true,
            fillColor: backgroundForTextField,
            hoverColor: backgroundForTextField,
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: fontGrey, width:1),
                borderRadius: BorderRadius.circular(10)),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 0.0),
            hintText: hintText,
            hintStyle: const TextStyle(color: fontGrey),
          ),
          style:  TextStyle(
            color: fontGrey,
            fontWeight: FontWeight.w400,
            fontSize: 18,
            fontFamily: Poppins,
          ),
        ),
      ],
    );
  }
}

