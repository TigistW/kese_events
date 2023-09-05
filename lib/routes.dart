import 'package:flutter/material.dart';
import 'package:kese_events/features/authentication/presentation/screens/splash_page.dart';

class PageRouter {
   Route<dynamic>? generateRoute(RouteSettings settings) {

    switch( settings.name){
      case SplashPage.routeName:
        return MaterialPageRoute(builder: (context) {
          return const SplashPage();
        });
    }
   }
}