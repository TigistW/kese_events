import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kese_events/features/authentication/bloc/secure_storage.dart';
import 'package:kese_events/injector.dart';

class SignInDataProvider {

    final http.Client httpClient;
    SignInDataProvider({required this.httpClient});

Future<String> signInEmail( {required String email, required String password}) async {
    final config = await DependencyInjector.getAppConfig();

    try{
        final response = await httpClient.post(
          Uri.parse('http://192.168.43.250:8000/auth/token/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{"email": email, "password": password}),
        );  

      if (response.statusCode == 200) {
        SecureStorage _secureStorage = SecureStorage();
        final responseJson = jsonDecode(response.body) as Map<String, dynamic>;
        final token = responseJson['data']['token'] as String;
        await _secureStorage.persistEmailAndToken(
                  email, token);
      return response.body;
      } else {
        throw Exception('Failed to login user using email');
      }
    }
    catch(e) {
      return throw e.toString();
    }
  }
}