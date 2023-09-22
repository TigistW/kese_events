
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kese_events/core/shared_widgets/custome_icon_button.dart';
import 'package:kese_events/core/shared_widgets/custome_text_field.dart';
import 'package:kese_events/core/shared_widgets/loading_button_widget.dart';
import 'package:kese_events/core/shared_widgets/password_text_field.dart';
import 'package:kese_events/core/utils/colors.dart';
import 'package:kese_events/core/utils/constants.dart';
import 'package:kese_events/core/utils/icons.dart';
import 'package:kese_events/core/utils/validators.dart';
import 'package:kese_events/features/authentication/bloc/sign_in_bloc/sign_in_bloc.dart';
import 'package:kese_events/features/authentication/bloc/sign_in_bloc/sign_in_event.dart';
import 'package:kese_events/features/authentication/bloc/sign_up_email_bloc/sign_up_email_bloc.dart';
import 'package:kese_events/features/authentication/bloc/sign_up_email_bloc/sign_up_email_event.dart';
import 'package:kese_events/features/authentication/bloc/sign_up_email_bloc/sign_up_email_state.dart';
import 'package:kese_events/features/authentication/presentation/screens/sign_in_page.dart';

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

  String fullname = '';

  String email = '';

  String password = '';

  String confirm_password = '';

  void _handleFormSubmitSignUp() {
    if (SignUpEmailForm._formKey.currentState!.validate() ==
                      false) {
                    return;
                  }
                  context.read<SignUpEmailBloc>().add(SignUpUserWithEmail(
                        fullname: fullname,
                        email_address: email,
                        password: password,
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
                        hintText: 'Fullname',
                        prefixIcon: profileIcon,
                        validator: (value) =>
                            _validator.validateName(value)?.toString(),
                        onChanged: (value) {
                          setState(() {
                            fullname = value;
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
                SignUpEmailForm._formKey.currentState?.reset();
                Navigator.pushNamed(
                  context,
                  '',
                );
                return;
              }
              if (state is SignUpEmailError) {}
              if (state is SignUpEmailVerifyOTPInitial) {
                Navigator.pushNamed(
                    context,'');
                return;
              }
            },
            builder: (context, state) {
              if (state is SignUpEmailLoading) {
                return getLoadingWidget(
                    widget.screenHeight, screenWidth, themeColor);
              }
              if (state is SignUpEmailWaitForOTP) {
                return getLoadingWidget(
                    widget.screenHeight, screenWidth, themeColor);
              }
                return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: themeColor,
                  minimumSize: const Size.fromHeight(45),
                ),
                child: const Text(
                  'SIGN UP',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'poppins',
                      fontSize: 16),
                ),
                onPressed: () {
                  _handleFormSubmitSignUp();
                },
              );
            
            }
          ),
            SizedBox(
            height: screenHeight * 0.03,
          ),
          const Text("OR", textAlign: TextAlign.center),
          SizedBox(
            height: screenHeight * 0.03,
          ),
          Container(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(45),
                  ),
                  onPressed: () {
                    context.read<SignInBloc>().add(SigninWithGoogle());
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 15,
                            child: SvgPicture.string(google_icon,
                                height: screenHeight * 0.05625)),
                        const Text(
                          'Sign in with Google',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'poppins',
                              fontSize: 16),
                        )
                      ]))),

            
          SizedBox(
            height: screenHeight * 0.1,
          ),
          
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      TextButton(
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: themeColor),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context,SignInPage.routeName);
                      },
                    ),
        ]
        )
      )
      ]
    )
    );
  }
}
