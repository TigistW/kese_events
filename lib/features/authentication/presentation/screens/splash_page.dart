import 'package:flutter/material.dart';
import 'package:kese_events/features/authentication/presentation/screens/sign_in_page.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = "/splashpage";
  const SplashPage({Key? key}) : super(key: key);
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<SplashPage> {
    @override
  void initState() {
    super.initState();
    
    _navigatetohome();
  }
  _navigatetohome() async {
    Future.delayed(
      const Duration(milliseconds: 1500),
      () => {
            Navigator.pushNamed(
              context,
              SignInPage.routeName,
            ),
          }
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.075),
                    child: const Text(
                      "Kese Events",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w100,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
