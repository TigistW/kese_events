import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kese_events/injector.dart';

class SignUpEmailDataProvider {

  final http.Client httpClient;
  SignUpEmailDataProvider({required this.httpClient});

  Future<Map<String, dynamic>> checkEmail(String emailAddress) async {
    final config = await DependencyInjector.getAppConfig();
    
    var data = json.encode({"email": emailAddress});
    var response = await httpClient.post(
      Uri.parse('http://192.168.43.250:8000/auth/check_email/'),
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
    required String confirmPassword,
  }) async {
    final config = await DependencyInjector.getAppConfig();

    var data = json.encode({
      "first_name": firstName,
      "last_name": lastName,
      "email": emailAddress,
      "password": password,
      "confirmPassword":confirmPassword
    });
    print(Uri.parse('${config!.baseApiUrl}/auth/signup_with_email/'));
    try{
    
    var response = await httpClient.post(
      Uri.parse('http://192.168.43.250:8000/auth/signup_with_email/'),
      body: data,
      headers: <String, String>{'Content-Type': 'application/json'},
    );
    print(response.body);
    return jsonDecode(response.body);}
    catch(e){
      print(e.toString());
      return throw e.toString();
    }
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
      Uri.parse('http://192.168.43.250:8000/auth/verify_otp/'),
      body: data,
      headers: <String, String>{'Content-Type': 'application/json'},
    );
    print("response");
    print(response.body);
    return jsonDecode(response.body);
  }
}
