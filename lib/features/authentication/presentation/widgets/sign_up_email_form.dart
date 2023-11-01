
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kese_events/core/shared_widgets/custome_button_auth.dart';
import 'package:kese_events/core/shared_widgets/custome_icon_button.dart';
import 'package:kese_events/core/shared_widgets/custome_text_field.dart';
import 'package:kese_events/core/shared_widgets/loading_button_widget.dart';
import 'package:kese_events/core/shared_widgets/password_text_field.dart';
import 'package:kese_events/core/utils/colors.dart';
import 'package:kese_events/core/utils/constants.dart';
import 'package:kese_events/core/utils/fonts.dart';
import 'package:kese_events/core/utils/icons.dart';
import 'package:kese_events/core/utils/validators.dart';
import 'package:kese_events/features/authentication/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:kese_events/features/authentication/bloc/sign_in_bloc/sign_in_event.dart';
import 'package:kese_events/features/authentication/bloc/sign_up_email_bloc/sign_up_email_bloc.dart';
import 'package:kese_events/features/authentication/bloc/sign_up_email_bloc/sign_up_email_event.dart';
import 'package:kese_events/features/authentication/bloc/sign_up_email_bloc/sign_up_email_state.dart';
import 'package:kese_events/features/authentication/presentation/screens/otp_email_verification_page.dart';
import 'package:kese_events/features/authentication/presentation/screens/sign_in_page.dart';
import 'package:kese_events/features/event/presentation/screens/home_page.dart';
import 'package:lottie/lottie.dart';

class SignUpEmailForm extends StatefulWidget {
  SignUpEmailForm({
    Key? key,
    required this.screenHeight,
    required this.screenWidth,
  }) : super(key: key);

  static final _formKey = GlobalKey<FormState>();
  double screenHeight;
  double screenWidth;

  @override
  State<SignUpEmailForm> createState() => _SignUpWithEmailState();
}

class _SignUpWithEmailState extends State<SignUpEmailForm> {
  void validate() {
    print(SignUpEmailForm._formKey.currentState!.validate());
  }

  String firstName = '';

  String lastName = '';

  String email = '';

  String password = '';

  String confirm_password = '';

  void _handleFormSubmitSignUp() {
    if (SignUpEmailForm._formKey.currentState!.validate() ==
                      false) {
                    return;
                  }
                  context.read<SignUpEmailBloc>().add(SignUpUserWithEmail(
                        firstName: firstName,
                        lastName: lastName,
                        email_address: email,
                        password: password,
                        confirm_password: confirm_password
                      ));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    Validators _validator = Validators();
    return Form(
      key: SignUpEmailForm._formKey,
      child: Column(
        children: [
          Column(
            children: [
              CustomTextField(
                        hintText: 'First name',
                        prefixIcon: profileIcon,
                        validator: (value) =>
                            _validator.validateName(value)?.toString(),
                        onChanged: (value) {
                          setState(() {
                            firstName = value;
                          });
                        }),
              CustomTextField(
                  hintText: 'Last name',
                  prefixIcon: profileIcon,
                  validator: (value) =>
                      _validator.validateName(value)?.toString(),
                  onChanged: (value) {
                    setState(() {
                      lastName = value;
                    });
                  }), 

              CustomTextField(
                  hintText: 'Email',
                  inputType: TextInputType.emailAddress,
                  prefixIcon: emailIcon,
                  validator: (value) =>
                      _validator.validateEmail(value)?.toString(),
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  }),
              PasswordField(
                  hintText: "Password",
                  prefixIcon: lockIcon,
                  validator: (value) =>
                      _validator.validatePassword(value)?.toString(),
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  }),
              PasswordField(
                  hintText: "Confirm Password",
                  prefixIcon: lockIcon,
                  validator: (value) =>
                      _validator.validateConfirmPassword(password, value),
                  onChanged: (value) {
                    setState(() {
                      confirm_password = value;
                    });
                  }),
                   SizedBox(
                height: screenHeight * 0.065,
              ),
            ],
          ),
         
          BlocConsumer<SignUpEmailBloc, SignUpEmailState>(
            listener: (context, state) {
              if (state is SignUpEmailAlreadyExists) {
                // SignUpEmailForm._formKey.currentState?.reset();
                Navigator.pushNamed(
                  context,
                  '',
                );
                return;
              }
              if (state is SignUpEmailError) {}
              if (state is SignUpEmailVerifyOTPInitial) {
                Navigator.pushNamed(
                    context,OtpEmailVerificationPage.routeName);
                return;
              }
            },
            builder: (context, state) {
              if (state is SignUpEmailLoading) {
                // return getLoadingWidget(
                //     widget.screenHeight, screenWidth, themeColor);
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
              if (state is SignUpEmailWaitForOTP) {
                // return getLoadingWidget(
                //     widget.screenHeight, screenWidth, themeColor);
                return Container(
                        height: screenHeight * 0.1,
                        child: Lottie.asset(
                          'assets/lottie/loading_lottie.json',
                          width: screenHeight * 0.3,
                          height: screenHeight * 0.3,
                          repeat: true, // Set to true to loop the animation
                        ),
                      );
              }return CustomButtonAuth(
                labelText: "Sign Up",
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  _handleFormSubmitSignUp();
                },
              );
            }
          ),
            SizedBox(
            height: screenHeight * 0.027,
          ),
          Text("OR", style: TextStyle(
                  color: fontGrey,
                  fontSize: 21,
                  fontFamily: Poppins,
                  fontWeight: FontWeight.w400),
              textAlign: TextAlign.center),
          SizedBox(
            height: screenHeight * 0.027,
          ),
         CustomButtonGoogleAuth(
            labelText: 'Login with Google',
            onPressed: () {
              context.read<SignInBloc>().add(SigninWithGoogle());
            },
          ),
            
          SizedBox(
            height: screenHeight * 0.05,
          ),
          
          HaveAnAccount(
            labelText: "Already have an account?",
            labelText2: "Sign in",
            onPressed: () {
              Navigator.pushNamed(context, OtpEmailVerificationPage.routeName);
            },
          )
      ]
    )
    );
  }
}
