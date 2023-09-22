import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kese_events/features/authentication/presentation/screens/splash_page.dart';
import 'package:kese_events/features/notification/notification_cubit/notification_cubit.dart';
import 'package:kese_events/injector..dart';
import 'package:kese_events/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final PageRouter _pageRouter = PageRouter();
  // const MyApp({super.key});

  // This widget is the root of your application. TBC

  final NotificationCubit _notificationCubit =
      DependencyInjector.getNotificationCubit()!;
  final _messengerKey = GlobalKey<ScaffoldMessengerState>();


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NotificationCubit>.value(
          value: _notificationCubit,
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<NotificationCubit, NotificationState>(
              listener: (_, state) {
            if (state is NotificationError) {
              _messengerKey.currentState!.hideCurrentSnackBar();
              _messengerKey.currentState!.showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  duration: const Duration(seconds: 10),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Color.fromARGB(255, 238, 78, 15),
                  action: SnackBarAction(
                    label: "close",
                    textColor: Colors.white,
                    onPressed: () =>
                        _messengerKey.currentState!.hideCurrentSnackBar(),
                  ),
                ),
              );
              _notificationCubit.notificationInitital();
              return;
            }
            if (state is NotificationSuccess) {
              _messengerKey.currentState!.hideCurrentSnackBar();
              _messengerKey.currentState!.showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  duration: const Duration(seconds: 10),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.green.shade400,
                  action: SnackBarAction(
                    label: "close",
                    textColor: Colors.white,
                    onPressed: () =>
                        _messengerKey.currentState!.hideCurrentSnackBar(),
                  ),
                ),
              );

              _notificationCubit.notificationInitital();
              return;
            }
          })
        ],
        child: MaterialApp(
          scaffoldMessengerKey: _messengerKey,
          debugShowCheckedModeBanner: false,
          title: 'Keseevents',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          initialRoute: SplashPage.routeName,
          onGenerateRoute: _pageRouter.generateRoute,
        ),
      ),
    );
  }
} 