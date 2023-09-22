import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kese_events/injector..dart';

class SignUpEmailDataProvider {
  final http.Client httpClient;

  SignUpEmailDataProvider({required this.httpClient});

  Future<Map<String, dynamic>> checkEmail(String emailAddress) async {
    final config = await DependencyInjector.getAppConfig();
    
    var data = json.encode({"email": emailAddress, "password": ""});
    
    var response = await httpClient.post(
      Uri.parse('${config!.baseApiUrl}/auth/signup-with-email/'),
      body: data,
      headers: <String, String>{'Content-Type': 'application/json'},
    );
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> signUpUserWithEmail({
    required String firstName,
    required String lastName,
    required String emailAddress,
    required String password,
  }) async {
    final config = await DependencyInjector.getAppConfig();

    var data = json.encode({
      "firstname": firstName,
      "lastname": lastName,
      "email": emailAddress,
      "password": password
    });
    var response = await httpClient.post(
      Uri.parse('${config!.baseApiUrl}/auth/signup-with-email/'),
      body: data,
      headers: <String, String>{'Content-Type': 'application/json'},
    );
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> verifyOTP({
    required String emailAddress,
    required String otp,
  }) async {
    var data = json.encode({
      "email": emailAddress,
      "otp": otp,
    });
    final config = await DependencyInjector.getAppConfig();
    var response = await httpClient.post(
      Uri.parse('${config!.baseApiUrl}/auth/verify/'),
      body: data,
      headers: <String, String>{'Content-Type': 'application/json'},
    );
    return jsonDecode(response.body);
  }
}
