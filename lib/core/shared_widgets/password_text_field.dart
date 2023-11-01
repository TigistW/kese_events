import 'package:flutter/material.dart';
import 'package:kese_events/core/shared_widgets/shared_widgets.dart';
import 'package:kese_events/core/utils/utils.dart';


class PasswordField extends StatefulWidget {
  const PasswordField({
    Key? key,
    required this.hintText,
    required this.prefixIcon,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  final String hintText;
  final Icon prefixIcon;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SizedBox(
        //   height: screenHeight * 0.0065,
        // ),
        CustomTextFormField(
          validator: widget.validator,
          onChanged: widget.onChanged,
          obscureText: _obscureText,
          decoration: InputDecoration(
              prefixIcon: widget.prefixIcon,
              filled: true,
              fillColor: backgroundForTextField,
              hoverColor: backgroundForTextField,
              border: OutlineInputBorder(
                  borderSide:  const BorderSide(
                    color: fontGrey, 
                    width: 1),
                  borderRadius: BorderRadius.circular(10)),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: fontGrey, width: 1),
                  borderRadius: BorderRadius.circular(10)),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 0.0),
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: fontGrey),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: Icon(
                  _obscureText
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              )),
          style: TextStyle(
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
