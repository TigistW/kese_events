
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:kese_events/core/shared_widgets/custome_button_auth.dart';
import 'package:kese_events/core/shared_widgets/shared_widgets.dart';
import 'package:kese_events/features/authentication/presentation/screens/onboarding_page.dart';
import 'package:kese_events/features/authentication/presentation/screens/sign_up_email_page.dart';
import 'package:kese_events/features/event/presentation/screens/home_page.dart';
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
          Navigator.popAndPushNamed(context, HomePage.routeName);
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
                            return 'Email is required!';
                          } else {
                            value = value.trim();
                            isEmail = validator.emailValidator(value);
                            if (!isEmail) {
                              return 'Please enter a valid email';
                            }
                          }
                        },
                        onChanged: (value) {
                          isEmail = validator.emailValidator(value);
                          if (isEmail == true) {
                            email = value.trim();
                          }
                        });
                  },
                ),
                BlocBuilder<SignInBloc, SignInState>(
                  builder: (context, state) {
                    return PasswordField(
                        hintText: "Your password",
                        prefixIcon: lockIcon,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Password is required!';
                          } else {
                            passwordVal = validator.passwordValidator(value);
                            if (passwordVal) {
                            } else {
                              return 'Invalid password!';
                            }
                          }
                        },
                        onChanged: (value) {
                          password = value;
                        });
                  },
                ),
               
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
                        child:  Text(
                          "Remember Me",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              fontFamily:Poppins,
                              color: fontGrey),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context,'');
                        },
                      ),
                        ]),
                      ),
                      
                      TextButton(
                        child:  Text(
                          "Forgot Password?",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: themeColor,
                              fontFamily:Poppins),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, '');
                        },
                      ),
                    ],
                  ),
                ),
                 BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
                  return state.formState is SubmissionFailed
                      ? Container(
                          padding: const EdgeInsets.all(20),
                          child:  Text(
                            'Sign in failed, please try again.',
                            style: TextStyle(
                              fontSize: 18,
                                color: choiceMarkerWrong, fontFamily: Poppins),
                          ),
                        )
                      : Container();
                }),
                // SizedBox(
                //   height: screenHeight * 0.03,
                // ),
                BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
                  return state.formState is FormSubmitting
                      // ? const CircularProgressIndicator()
                      ? Container(
                        height: screenHeight * 0.1,
                        child: Lottie.asset(
                          'assets/lottie/loading_lottie.json',
                          width: screenHeight * 0.3,
                          height: screenHeight * 0.3,
                          repeat: true, // Set to true to loop the animation
                        ),
                      )
                      : CustomButtonAuth(
                        labelText: 'Log In',
                        icon: Icon(Icons.arrow_forward, color: blackText,),
                        onPressed: _handleFormSubmit,);
                }),
                SizedBox(
                  height: screenHeight * 0.017,
                ),
                Text(
                  "OR",
                  style: TextStyle(color: fontGrey, fontSize: 21, fontFamily: Poppins, fontWeight: FontWeight.w400),
                  textAlign:TextAlign.center
                ),
                 SizedBox(
                  height: screenHeight * 0.017,
                ),
                CustomButtonGoogleAuth(
                        labelText: 'Login with Google',
                        onPressed: () {
                              context
                                  .read<SignInBloc>()
                                  .add(SigninWithGoogle());
                            },),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                HaveAnAccount(
                  labelText:"Don't have an account?" ,
                  labelText2: "Sign up",
                  onPressed: () {
                        Navigator.pushNamed(context,SignUpEmailPage.routeName);
                      },
                  )
              ],
            ),
          )
      ),
    );
  }
}
