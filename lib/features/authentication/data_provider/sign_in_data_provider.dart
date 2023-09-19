import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kese_events/injector..dart';

class SignInDataProvider {
    final http.Client httpClient;

  SignInDataProvider({required this.httpClient});

    Future<String> signInEmail(
      {required String email, required String password}) async {
    final config = await DependencyInjector.getAppConfig();

    final responsEmail = await httpClient.post(
      Uri.parse('${config!.baseApiUrl}/auth/login_email/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{"email": email, "password": password}),
    );

    if (responsEmail.statusCode == 200) {
      return responsEmail.body;
    } else {
      throw Exception('Failed to login user using email');
    }
  }
}