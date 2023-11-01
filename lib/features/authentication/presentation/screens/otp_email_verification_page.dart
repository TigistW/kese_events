import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kese_events/core/shared_widgets/custome_button_auth.dart';
import 'package:kese_events/core/shared_widgets/snac_bar_widget.dart';
import 'package:kese_events/core/utils/colors.dart';
import 'package:kese_events/core/utils/constants.dart';
import 'package:kese_events/core/utils/fonts.dart';
import 'package:kese_events/features/authentication/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:kese_events/features/authentication/bloc/sign_in_bloc/sign_in_event.dart';
import 'package:kese_events/features/authentication/bloc/sign_up_email_bloc/sign_up_email_bloc.dart';
import 'package:kese_events/features/authentication/bloc/sign_up_email_bloc/sign_up_email_event.dart';
import 'package:kese_events/features/authentication/bloc/sign_up_email_bloc/sign_up_email_state.dart';
import 'package:kese_events/features/authentication/presentation/screens/sign_in_page.dart';
import 'package:kese_events/features/authentication/presentation/widgets/auth_widgets.dart';
import 'package:kese_events/features/authentication/presentation/widgets/otp_text.dart';
import 'package:kese_events/features/event/presentation/screens/home_page.dart';
import 'package:lottie/lottie.dart';
// import 'package:pin_entry_text_field/pin_entry_text_field.dart';

class OtpEmailVerificationPage extends StatelessWidget {
  static const String routeName = "/otp_email_verification_page";
  OtpEmailVerificationPage({Key? key}) : super(key: key);

  // final _formKey = GlobalKey<FormState>();
  String code = '';
  final List<TextEditingController> otp_input_controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  bool areAllOTPFilled(List<TextEditingController> controllers) {
  for (var controller in controllers) {
    if (controller.text.isEmpty) {
      return false;
    }
  }
  return true;
}
  
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
                          left: screenWidth * 0.07, 
                          right: screenWidth * 0.1),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.of(context)
                                  .pop(); // Pop the current page
                            },
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(),
                    OtpText(
                      type: "Email",
                    ),
                    SizedBox(height: screenHeight * inbetweenPadding),
                    Container(
                      padding: EdgeInsets.only(
                        left: screenWidth * 0.1,
                        right: screenWidth * 0.1,
                        bottom: screenHeight * bottomPadding4,
                      ),
                      child: Column(children: [
                        Container(
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _textFieldOtp(
                                  first: true,
                                  last: false,
                                  controller: otp_input_controllers[0],
                                  context: context,
                                ),
                                _textFieldOtp(
                                  first: false,
                                  last: false,
                                  controller: otp_input_controllers[1],
                                  context: context,
                                ),
                                _textFieldOtp(
                                  first: false,
                                  last: false,
                                  controller: otp_input_controllers[2],
                                  context: context,
                                ),
                                _textFieldOtp(
                                  first: false,
                                  last: true,
                                  controller: otp_input_controllers[3],
                                  context: context,
                                ),
                              ],
                            )
                          ]),
                        ),
                        SizedBox(height: screenHeight * bottomPadding2),
                        BlocConsumer<SignUpEmailBloc, SignUpEmailState>(
                          listener: (context, state) {
                            if (state is SignUpEmailInvalidOTP) {
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  customSnacBar(
                                    context: context,
                                    color: const Color.fromARGB(255, 255, 35, 19),
                                    body: Text(state.message),
                                    direction: "top",
                                  ),
                                );
                            }
                            if (state is SignUpEmailOTPVerifySuccess) {
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  customSnacBar(
                                    context: context,
                                    color: Colors.green,
                                    body: Text("email has been verified"),
                                    direction: "top",
                                  ),
                                );
                              Navigator.pushNamed(
                                  context, SignInPage.routeName);
                            }
                          },

                          builder: (_, state) {
                            if (state is SignUpEmailVerifyOTPWaiting) {
                              return Container(
                        height: screenHeight * 0.1,
                        child: Lottie.asset(
                          'assets/lottie/loading_lottie.json',
                          width: screenHeight * 0.3,
                          height: screenHeight * 0.3,
                          repeat: true, // Set to true to loop the animation
                        ),
                      );
                            }
                            return CustomButtonAuth(
                              enabled: areAllOTPFilled(otp_input_controllers),
                              labelText: "CONTINUE", 
                              icon: Icon(Icons.arrow_forward),
                              onPressed: () {
                                String OTP = "";
                                for (var element in otp_input_controllers) {
                                  OTP += element.text;
                                }
                                if (OTP.length != 4) {
                                  ScaffoldMessenger.of(context)
                                    ..hideCurrentSnackBar()
                                    ..showSnackBar(
                                      customSnacBar(
                                        context: context,
                                        color: const Color.fromARGB(255, 255, 35, 19),
                                        body: Text("Invalid Otp"),
                                        direction: "top",
                                      ),
                                    );
                                }

                                context.read<SignUpEmailBloc>().add(VerifyOtp(
                                      email_address: state.email_address,
                                      password: state.password,
                                      OTP: OTP,
                                    ));

                                
                                // emit verify OTP
                                // pass Both email_address and OTP
                                // depending on the response redirect user to the login page
                                // or to the home page as a logged in user
                              },
                              
                            );
                          },
                        ),
                        SizedBox(height: screenHeight * 0.05,),
                        TextButton(
                        onPressed: () {
                            Navigator.pushNamed(context, SignInPage.routeName); 
                           },
                        child: Text("Resend code TBI"),
                          )
                      ]
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }


Widget _textFieldOtp(
      {
        bool? first,last,
      required TextEditingController controller,
      required BuildContext context}) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
        height: screenHeight * 0.08,
        width: screenWidth * 0.13256410256,
        color: whitishBackground,
        child: AspectRatio(
          aspectRatio:0.8,
          child: TextField(
            style: TextStyle(
              fontSize: 30, 
              fontWeight: FontWeight.w800, 
              fontFamily: Poppins,
              color: fontGrey),
            autofocus: true,
            onChanged: (value) {
              controller.text = value;
              if (value.length == 1 && last == false) {
                FocusScope.of(context).nextFocus();
              }
              if (value.length == 0 && first == false) {
                FocusScope.of(context).previousFocus();
              }
            },
            showCursor: true,
            readOnly: false,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderSide: const BorderSide(color: fontGrey),
                  borderRadius: BorderRadius.circular(10)),
              counter: Offstage(),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: fontGrey),
                  borderRadius: BorderRadius.circular(10)),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: themeColor),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        )
        // ),
    );
  }
}
