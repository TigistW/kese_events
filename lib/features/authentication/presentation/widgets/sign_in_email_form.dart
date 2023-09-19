
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kese_events/core/shared_widgets/shared_widgets.dart';
import 'package:kese_events/features/authentication/presentation/screens/onboarding_page.dart';
import '../../../../core/utils/utils.dart';
import '../../bloc/sign_in_bloc/index.dart';
import 'package:flutter_advanced_switch/flutter_advanced_switch.dart';

class SignInEmailForm extends StatefulWidget {
  const SignInEmailForm({Key? key}) : super(key: key);

  @override
  _SignInEmailFormState createState() => _SignInEmailFormState();
}

class _SignInEmailFormState extends State<SignInEmailForm> {

  final _controller = ValueNotifier<bool>(false);

  final _formKey = GlobalKey<FormState>();
  String email = '';
  String phone = '';
  String password = '';
  bool isEmail = false;
  bool passwordVal = false;
  bool _checked = false;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      setState(() {
        if (_controller.value) {
          _checked = true;
        } else {
          _checked = false;
        }
      });
    });
  }

  void _handleFormSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (isEmail && passwordVal) {
        print("email is being used");
        context
            .read<SignInBloc>()
            .add(SigninEmailSubmitted(email: email.trim(), password: password));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    Validators validator = Validators();

    return BlocListener<SignInBloc, SignInState>(
      bloc: BlocProvider.of<SignInBloc>(context),
      listener: (BuildContext context, state) {
        if (state.formState is SubmissionSuccess) {
          print("submission success emmitted");
          Navigator.popAndPushNamed(context, OnboardingPage.routeName);
        }
      },
      child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.only(
              left: screenWidth * 0.1,
              right: screenWidth * 0.1,
            ),
            child: Column(
              children: [
                BlocBuilder<SignInBloc, SignInState>(
                  builder: (context, state) {
                    return CustomTextField(
                        hintText: 'abc@gmail.com',
                        prefixIcon: emailIcon,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Field is required';
                          } else {
                            value = value.trim();
                            isEmail = validator.emailValidator(value);
                            print("vvvvvvvvvvvvvvvvvvvv");
                            print(isEmail);

                            if (!isEmail) {
                              return 'Please enter a valid email';
                            }
                          }
                        },
                        onChanged: (value) {
                          isEmail = validator.emailValidator(value);

                          if (isEmail == true) {
                            email = value.trim();
                            print("hhhhhhhhhhhhhhhhhhhhhh");
                            print(email);
                          }
                        });
                  },
                ),
                BlocBuilder<SignInBloc, SignInState>(
                  builder: (context, state) {
                    return PasswordField(
                        hintText: "Your Password",
                        prefixIcon: lockIcon,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Field is required!';
                          } else {
                            passwordVal = validator.passwordValidator(value);
                            if (passwordVal) {
                            } else {
                              return 'Invalid input!';
                            }
                          }
                        },
                        onChanged: (value) {
                          password = value;
                        });
                  },
                ),
                BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
                  return state.formState is SubmissionFailed
                      ? Container(
                          padding: const EdgeInsets.all(20),
                          child: const Text(
                            'Sign in failed, please try again.',
                            style: TextStyle(
                                color: choiceMarkerWrong, fontFamily: 'Roboto'),
                          ),
                        )
                      : Container();
                }),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(children: [
                          AdvancedSwitch(
                            controller: _controller,
                            activeColor: Colors.green,
                            inactiveColor: Colors.grey,
                            
                            borderRadius:
                                BorderRadius.all(const Radius.circular(25)),
                            width: 50.0,
                            height: 25.0,
                            enabled: true,
                            disabledOpacity: 0.5,
                          ),

                          TextButton(
                        child: const Text(
                          "Remember Me",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: themeColor),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context,'');
                        },
                      ),
                        ]),
                      ),
                      
                      TextButton(
                        child: const Text(
                          "Forgot Password?",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: themeColor),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, '');
                        },
                      ),
                    ],
                  ),
                ),
                
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
                  return state.formState is FormSubmitting
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: themeColor,
                            minimumSize: const Size.fromHeight(45),
                            
                          ),
                          child: const Text(
                            'Sign in',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'poppins',
                                fontSize: 16),
                          ),
                          onPressed: () {
                            _handleFormSubmit();
                          },
                        );
                }),
                 SizedBox(
                  height: screenHeight * 0.03,
                ),
                Text(
                  "OR",
                  textAlign:TextAlign.center
                ),
                 SizedBox(
                  height: screenHeight * 0.03,
                ),

                Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton(
                            elevation: 2,
                            backgroundColor: Colors.white,
                            onPressed: () {
                              context
                                  .read<SignInBloc>()
                                  .add(SigninWithGoogle());
                            },
                            child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 15,
                                child: SvgPicture.asset(
                                    "assets/images/google_icon.svg"))),
                        TextButton(
                          child: const Text(
                            "Sign in with Google",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: fontGrey),
                          ),
                          onPressed: () {
                            context.read<SignInBloc>().add(SigninWithGoogle());
                          },
                        ),
                      ]),
                ),
                SizedBox(
                  height: screenHeight * 0.1,
                )
              ],
            ),
          )),
    );
  }
}
