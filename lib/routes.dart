import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kese_events/features/authentication/bloc/sign_up_email_bloc/sign_up_email_bloc.dart';
import 'package:kese_events/features/authentication/presentation/screens/onboarding_page.dart';
import 'package:kese_events/features/authentication/presentation/screens/otp_email_verification_page.dart';
import 'package:kese_events/features/authentication/presentation/screens/sign_in_page.dart';
import 'package:kese_events/features/authentication/presentation/screens/sign_up_email_page.dart';
import 'package:kese_events/features/authentication/presentation/screens/splash_page.dart';
import 'package:kese_events/features/event/bloc/event_bloc/event_bloc.dart';
import 'package:kese_events/features/event/bloc/event_detail_bloc/event_detail_bloc.dart';
import 'package:kese_events/features/event/bloc/filter_by_tag_bloc/filter_by_tag_bloc.dart';
import 'package:kese_events/features/event/bloc/tag_bloc/tag_bloc.dart';
import 'package:kese_events/features/event/bloc/upcoming_event_bloc.dart/upcoming_event_bloc.dart';
import 'package:kese_events/features/event/presentation/screens/event_detail_page.dart';
import 'package:kese_events/features/event/presentation/screens/home_page.dart';
import 'package:kese_events/features/event/presentation/widgets/event_list_content.dart';
import 'package:kese_events/features/notification/notification_cubit/notification_cubit.dart';
import 'package:kese_events/features/payment/bloc/payment/payment_bloc.dart';
import 'package:kese_events/features/payment/presentation/screens/Checkout_page.dart';
import 'package:kese_events/features/payment/presentation/screens/payment_page.dart';
import 'package:kese_events/features/profile/bloc/profile_bloc/profile_bloc.dart';
import 'package:kese_events/features/profile/presentation/screens/profile_page.dart';
import 'package:kese_events/injector.dart';
import 'package:kese_events/models/event/event.dart';

class PageRouter {
  
  final NotificationCubit _notificationCubit =
      DependencyInjector.getNotificationCubit()!;

  final SignUpEmailBloc _signUpBloc = SignUpEmailBloc(
    signUpEmailRepository: DependencyInjector.getSignUpEmailRepository()!,
    notificationCubit: DependencyInjector.getNotificationCubit()!,
  );

    final EventDetailBloc _eventDetailBloc = EventDetailBloc(
      eventDetailRepository:DependencyInjector.getEventRepository()!);

    final PaymentBloc _paymentBloc = PaymentBloc(
      paymentRepository:DependencyInjector.getPaymentRepository()!, 
      userHiveRepository: DependencyInjector.getUserHiveRepository()!, 
      eventDetailRepository: DependencyInjector.getEventRepository()!);

    final ProfileBloc _profileBloc = ProfileBloc(
      userHiveRepository:DependencyInjector.getUserHiveRepository()!);

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

            RepositoryProvider(
                create: (BuildContext context) =>
                    DependencyInjector.getProfileRepository()),
            RepositoryProvider(
                create: (BuildContext context) =>
                    DependencyInjector.getProfileRepository()),

          ], child: const SignInPage());
        });

      case SignUpEmailPage.routeName:
        return MaterialPageRoute(builder: (context) {
          return BlocProvider<SignUpEmailBloc>.value(
            value: _signUpBloc,
            child: SignUpEmailPage(),
          );
        });


        case HomePage.routeName:
        return MaterialPageRoute(builder: (context) {
          return MultiBlocProvider(providers: [
            BlocProvider<EventBloc>(
            create: (BuildContext context) => 
            EventBloc(
              eventRepository: DependencyInjector.getEventRepository()!,
            ),),

            BlocProvider<UpcomingEventBloc>(
              create: (BuildContext context) => UpcomingEventBloc(
                eventRepository: DependencyInjector.getEventRepository()!,
              ),
            ),

             BlocProvider<TagBloc>(
              create: (BuildContext context) => TagBloc(
                tagRepository: DependencyInjector.getTagRepository()!,
              ),
            ),

             BlocProvider<FilterByTagBloc>(
              create: (BuildContext context) => FilterByTagBloc(
                eventRepository: DependencyInjector.getEventRepository()!,
              ),
            ),

          ], child: HomePage());
        }
        );

        case ProfilePage.routeName:
        return MaterialPageRoute(builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<ProfileBloc>(
                create: (BuildContext context) => ProfileBloc(
                  userHiveRepository:  DependencyInjector.getUserHiveRepository()!,
                  
                ),
              ),
            ],
            child: ProfilePage(selected: true,),
          );
        });


      case OtpEmailVerificationPage.routeName:
        return MaterialPageRoute(builder: (context) {
          return BlocProvider.value(
            value: _signUpBloc,
            child: OtpEmailVerificationPage(),
          );
        });

      // case EventListContent.routeName:
      //   return MaterialPageRoute(builder: (context) {
      //               return MultiBlocProvider(providers: [
      //       BlocProvider<EventBloc>(
      //       create: (BuildContext context) => 
      //       EventBloc(
      //         eventRepository: DependencyInjector.getEventRepository()!,
      //       ),),

      //        BlocProvider<TagBloc>(
      //         create: (BuildContext context) => TagBloc(
      //           tagRepository: DependencyInjector.getTagRepository()!,
      //         ),
      //       ),

      //        BlocProvider<FilterByTagBloc>(
      //         create: (BuildContext context) => FilterByTagBloc(
      //           eventRepository: DependencyInjector.getEventRepository()!,
      //         ),
      //       ),

      //     ], child: EventListContent());
      //   });


        case EventDetailPage.routeName:
        // Event event = settings.arguments as Event;
         return MaterialPageRoute(builder: (context) {
          return BlocProvider.value(
            value: _eventDetailBloc,
            child: EventDetailPage(event: settings.arguments as Event),
          );
        });

        case CheckoutPage.routeName:
        return MaterialPageRoute(builder: (context) {
          return CheckoutPage(response: settings.arguments as List<Object>);
        });

        case PaymentPage.routeName:
         return MaterialPageRoute(builder: (context) {
          // return MultiRepositoryProvider(providers: [
          //   RepositoryProvider(
          //       create: (BuildContext context) =>
          //           DependencyInjector.getUserHiveRepository()),

          //   RepositoryProvider(
          //       create: (BuildContext context) =>
          //           DependencyInjector.getEventProvider()),
          //   RepositoryProvider(
          //       create: (BuildContext context) =>
          //           DependencyInjector.getPaymentRepository()),

          // ], child:  PaymentPage(event: settings.arguments as Event));
          return MultiBlocProvider(providers: [
             BlocProvider<PaymentBloc>(
              create: (BuildContext context) => _paymentBloc,
              ),
              BlocProvider<EventDetailBloc>(
              create: (BuildContext context) => _eventDetailBloc,
              ),
              BlocProvider<ProfileBloc>(
              create: (BuildContext context) => _profileBloc,
              ),
          ], child:  PaymentPage(event: settings.arguments as Event,)
          );
        }
        );
    }
   }
}