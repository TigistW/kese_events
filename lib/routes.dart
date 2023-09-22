import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kese_events/features/authentication/bloc/sign_up_email_bloc/sign_up_email_bloc.dart';
import 'package:kese_events/features/authentication/presentation/screens/onboarding_page.dart';
import 'package:kese_events/features/authentication/presentation/screens/sign_in_page.dart';
import 'package:kese_events/features/authentication/presentation/screens/sign_up_email_page.dart';
import 'package:kese_events/features/authentication/presentation/screens/splash_page.dart';
import 'package:kese_events/features/notification/notification_cubit/notification_cubit.dart';
import 'package:kese_events/injector..dart';

class PageRouter {
  
  final NotificationCubit _notificationCubit =
      DependencyInjector.getNotificationCubit()!;

  final SignUpEmailBloc _signUpBloc = SignUpEmailBloc(
    signUpEmailRepository: DependencyInjector.getSignUpEmailRepository()!,
    notificationCubit: DependencyInjector.getNotificationCubit()!,
  );
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

      case SignUpEmailPage.routeName:
        return MaterialPageRoute(builder: (context) {
          return BlocProvider<SignUpEmailBloc>.value(
            value: _signUpBloc,
            child: SignUpEmailPage(),
          );
        });

        


    }
   }
}