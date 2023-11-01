import 'package:flutter/material.dart';
import 'package:kese_events/features/authentication/bloc/secure_storage.dart';
import 'package:kese_events/features/authentication/presentation/screens/onboarding_page.dart';
import 'package:kese_events/features/authentication/presentation/screens/sign_in_page.dart';
import 'package:kese_events/features/authentication/presentation/widgets/auth_widgets.dart';
import 'package:kese_events/features/event/presentation/screens/home_page.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = "/splashpage";
  const SplashPage({Key? key}) : super(key: key);
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<SplashPage> {

  late bool isLoggedIn = false;
  late bool isViewed = false;
  final SecureStorage _secureStorage = SecureStorage();
    @override
  void initState() {
    super.initState();
    
    _retrieveOnboardInfo();
    _retrieveisLoggedIn();
    _navigatetohome();
  }
    _retrieveisLoggedIn() async {
    isLoggedIn = await _secureStorage.hasToken();
  }

  _retrieveOnboardInfo() async {
    isViewed = await _secureStorage.hasBoarding();
  }
  _navigatetohome() async {
    Future.delayed(
      const Duration(milliseconds: 5000),
      () => {
            if (!isLoggedIn)
          {
            if (!isViewed)
              {
                _secureStorage.persistOnBoard("board"),
                Navigator.pop(context),
                Navigator.pushNamed(
                  context,
                  OnboardingPage.routeName,
                ),
              }
            else
              {
                Navigator.pop(context),
                Navigator.pushNamed(
                  context,
                  SignInPage.routeName,
                ),
              }
          }
        else
          {
            Navigator.pop(context),
            Navigator.pushNamed(
              context,
              HomePage.routeName,
            ),
          }
          }
    );
  }

  @override
  Widget build(BuildContext context) {
     final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body:Container(
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: screenHeight * 0.4),
          SplashPageLogo()
          ],
      ),
    )
    );
    
  
  }
}
