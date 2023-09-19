import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kese_events/features/authentication/bloc/sign_in_bloc/index.dart';
import 'package:kese_events/injector..dart';

import '../widgets/auth_widgets.dart';
import '../widgets/sign_in_email_form.dart';
import '../widgets/sign_in_text.dart';

class SignInPage extends StatelessWidget{
  const SignInPage({Key? key}) : super(key: key);
  static const String routeName = "/signin_page";


  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(0),
      child: BlocProvider(
        create: (context) {
          return SignInBloc(
            signInRepository: DependencyInjector.getSignInRepository()!,
          );
        },

        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: screenHeight * 0.1,
                        ),
                        Container(
                            padding:
                                EdgeInsets.only(top: screenHeight * 0.0289625),
                            child: Logo()),

                        Container(
                            padding:
                                EdgeInsets.only(top: screenHeight * 0.0289625),
                            child: LogoName()),

                        SizedBox(
                          height: screenHeight * 0.1,
                        ),
                        // SvgPicture.asset(
                        //   'assets/images/keselogo.svg',
                        //   height: screenWidth * 0.46153846153,
                        // ),
                        const SigninText(),
                        SizedBox(
                          height: screenHeight * 0.03,
                        ),
                        const SignInEmailForm(),
                      ]),
                )
                // ],
                ),
          ),
        ),
        // }
        // ),
      ),
    ));
  }

}