
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kese_events/core/utils/utils.dart';
import 'package:kese_events/features/authentication/presentation/screens/splash_page.dart';


class OnboardingPage extends StatelessWidget {
  static const String routeName = "/onboardingpage";

  const OnboardingPage({Key? key}) : super(key: key);

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    SizedBox(height: screenHeight * 0.01),
                    SvgPicture.asset('assets/images/onboarding.svg'),
                    SizedBox(height: screenHeight * 0.01),
                    Container(
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.12307692307,
                          right: screenWidth * 0.12307692307),
                      child:const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Hi,",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w100),
                          ),
                          Text(
                            "Welcome",
                            style: TextStyle(
                                fontSize: 40, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            "to the place where you find resources to escalate in your education",
                            style: TextStyle(fontWeight: FontWeight.w100),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(
                          top: screenHeight * 0.05,
                          left: screenWidth * 0.1,
                          right: screenWidth * 0.1,
                          bottom: screenHeight * bottomPadding1,
                        ),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: themeColor,
                            minimumSize: const Size.fromHeight(50),
                          ),
                          child: const Text(
                            'Get Started',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'poppins',
                                fontSize: 16),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, SplashPage.routeName);
                          },
                        ))
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
