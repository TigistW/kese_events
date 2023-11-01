
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kese_events/features/authentication/presentation/widgets/sign_up_email_form.dart';
import 'package:kese_events/features/authentication/presentation/widgets/sign_up_text.dart';
import '../../../../core/utils/utils.dart';


class SignUpEmailPage extends StatelessWidget {
  SignUpEmailPage({Key? key}) : super(key: key);
  static const String routeName = "/signup_email_page";

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: screenHeight * 0.065,
                  ),
                  Container(
                     padding: EdgeInsets.only(
                      left: screenWidth * 0.1,
                      right: screenWidth * 0.1
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.of(context).pop(); // Pop the current page
                          },
                        ),
                    ],
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                    
                  const SignupText(),
                  SizedBox(
                    height: screenHeight * 0.035,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.1,
                      right: screenWidth * 0.1,
                      // bottom: screenHeight * bottomPadding2,
                    ),
                    child: Column(children: [
                      SignUpEmailForm(
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                      ),
                    ]),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
