import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kese_events/core/utils/colors.dart';
import 'package:kese_events/core/utils/fonts.dart';
import 'package:kese_events/features/authentication/presentation/screens/sign_in_page.dart';
import 'package:kese_events/features/authentication/presentation/screens/splash_page.dart';

class OnboardingPage extends StatefulWidget {
  static const String routeName = "/onboardingpage";

  const OnboardingPage({Key? key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final List<Widget> onboardingPages = [
      // Define your onboarding pages here
      buildOnboardingPage(screenWidth, screenHeight,"assets/images/onboarding1.svg", "Page 1 content"),
      buildOnboardingPage(screenWidth, screenHeight,"assets/images/onboarding2.svg", "Page 2 content"),
      buildOnboardingPage(screenWidth, screenHeight,"assets/images/onboarding3.svg", "Page 3 content"),
    ];

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: onboardingPages,
            ),
          ),
          buildBottomNavigationBar(screenWidth, screenHeight, onboardingPages.length),
        ],
      ),
    );
  }

  Widget buildOnboardingPage(double screenWidth, double screenHeight, String imageAsset, String content) {
    return Container(
    // width: screenWidth * pageCount,
    //  height: screenHeight * 0.3,
    // padding: EdgeInsets.all(screenWidth * 0.1),
    margin: EdgeInsets.fromLTRB(screenWidth * 0.07,screenWidth * 0.05,screenWidth * 0.07, screenWidth * 0.05),

    decoration: const BoxDecoration(
          color: fontGrey,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60.0),
              topRight: Radius.circular(60.0),
              bottomLeft: Radius.circular(60.0),
              bottomRight: Radius.circular(60.0)
              )
              ),
      
      child: Column(
        
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(imageAsset),
          const SizedBox(height: 16),
          Text(
            content,
            style: const TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
String getBottomNavText(int currentPage) {
  switch (currentPage) {
    case 0:
      return 'Welcome to Page 1';
    case 1:
      return 'Explore Page 2';
    case 2:
      return 'Discover Page 3';
    default:
      return 'Welcome to Page 1';
  }
}
String getBottomNavTextSmall(int currentPage) {
  switch (currentPage) {
    case 0:
      return 'Welcome to Page 1';
    case 1:
      return 'Explore Page 2';
    case 2:
      return 'Discover Page 3';
    default:
      return 'Welcome to Page 1';
  }
}

Widget buildBottomNavigationBar(double screenWidth, double screenHeight,int pageCount) {
  return Container(
    width: screenWidth * pageCount,
     height: screenHeight * 0.3,

    decoration: const BoxDecoration(
          color: themeColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60.0),
              topRight: Radius.circular(60.0))),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Text(
            getBottomNavText(_currentPage), // Display text based on the current page
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontFamily: Poppins,
              fontWeight: FontWeight.w400
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            getBottomNavTextSmall(_currentPage), // Display text based on the current page
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: Poppins,
              fontWeight: FontWeight.w200
            ),
          ),
        ),
        SizedBox(
            height: screenHeight * 0.04 // Adjust the spacing as needed
          ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () {
                // Handle Skip action here
                // For example, you can navigate to another page
                Navigator.pushNamed(context, SignInPage.routeName);
              },
              child:  Text('Skip', 
              style: TextStyle(
                color: whitishBackground, 
                fontSize: 19, 
                fontFamily: Poppins, 
                fontWeight: FontWeight.w500
              ),
              ),
            ),

            //  SizedBox(
            //   width: screenWidth * 0.2, // Adjust the spacing as needed
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pageCount,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.circle,
                      color: _currentPage == index ? Colors.white : Colors.grey,
                      size: 9,
                    ),
                  );
                },
              ),
            ),
            
            //  SizedBox(
            //   width: screenWidth * 0.2,// Adjust the spacing as needed
            // ),

            TextButton(
              onPressed: () {
                if (_currentPage < pageCount - 1) {
                  _pageController.animateToPage(
                    _currentPage + 1,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                  
                }else{
                  Navigator.pushNamed(context, SignInPage.routeName);
                }
              },
              child: Text(
                'Next',
              style: TextStyle(
                color: whitishBackground, 
                fontSize: 19, 
                fontFamily: Poppins, 
                fontWeight: FontWeight.w500
              ),),
            ),
          ],
        ),
      ],
    ),
  );
}
}