import 'dart:convert';
import 'package:flutter/services.dart';

class AppConfig {
  final String baseApiUrl;

  AppConfig({required this.baseApiUrl});

  static Future<AppConfig> loadEnvironment() async {
    final contents =
        await rootBundle.loadString("assets/config/dev_config.json");
    final json = jsonDecode(contents);
    return AppConfig(baseApiUrl: json['baseApiUrl']);
  }
}
