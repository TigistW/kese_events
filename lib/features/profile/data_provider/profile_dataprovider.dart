import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kese_events/features/authentication/bloc/secure_storage.dart';
import 'package:kese_events/injector.dart';
import 'package:kese_events/models/user/user.dart';

class ProfileDataProvider {
  final http.Client httpClient;
  ProfileDataProvider({required this.httpClient});

  Future<User> get_user_profile() async {
    print("in profile data provider");

    final config = await DependencyInjector.getAppConfig();
    SecureStorage _secureStorage = SecureStorage();
    String? token = await _secureStorage.getToken();

    print(token);
    var response = await httpClient.get(
      Uri.parse('http://192.168.43.250:8000/auth/current_user/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + token!,
      },
    );
    print(response.body);
    final res = jsonDecode(response.body);
    print(res);
    User user = User.fromMap(res["data"]);

    print(user);

    if (response.statusCode == 200) {
      print(response.body);
      // print(User.fromJson(jsonDecode(response.body)['data']));
      // return User.fromJson(jsonDecode(response.body)['data']);
      return user;
    } else {
      throw Exception('Failed to get user');
    }
  }
}