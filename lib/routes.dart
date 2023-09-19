import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kese_events/features/authentication/presentation/screens/onboarding_page.dart';
import 'package:kese_events/features/authentication/presentation/screens/sign_in_page.dart';
import 'package:kese_events/features/authentication/presentation/screens/splash_page.dart';
import 'package:kese_events/injector..dart';

class PageRouter {
   Route<dynamic>? generateRoute(RouteSettings settings) {

    switch( settings.name){
      case SplashPage.routeName:
        return MaterialPageRoute(builder: (context) {
          return const SplashPage();
        });

        case OnboardingPage.routeName:
        return MaterialPageRoute(builder: (context) {
          return const OnboardingPage();
        });

        case SignInPage.routeName:
        return MaterialPageRoute(builder: (context) {
          return MultiRepositoryProvider(providers: [
            RepositoryProvider(
                create: (BuildContext context) =>
                    DependencyInjector.getSignInRepository()!),
          ], child: const SignInPage());
        });

        


    }
   }
}