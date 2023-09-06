import 'package:flutter/material.dart';
import 'package:kese_events/features/authentication/presentation/screens/splash_page.dart';
import 'package:kese_events/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final PageRouter _pageRouter = PageRouter();
  // const MyApp({super.key});

  // This widget is the root of your application. TBC
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kese Events',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: SplashPage.routeName,
      onGenerateRoute: _pageRouter.generateRoute,
    );
  }
} 