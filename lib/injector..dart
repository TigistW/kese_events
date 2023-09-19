import 'package:http/http.dart' as http;
import 'package:kese_events/config.dart';
import 'package:kese_events/features/authentication/data_provider/sign_in_data_provider.dart';
import 'package:kese_events/features/authentication/repository/sign_in_repository.dart';
class DependencyInjector {
  static http.Client? _httpClient;
  static AppConfig? _config;
  static SignInDataProvider? _signInDataProvider;
  static SignInRepository? _signInRepository;

  static Future<AppConfig?> getAppConfig() async {
    _config ??= await AppConfig.loadEnvironment();
    return _config;
  }

  static http.Client? getHttpClient() {
    _httpClient ??= http.Client();
    return _httpClient;
  }

    static SignInDataProvider? getSignInDataProvider() {
    _signInDataProvider ??= SignInDataProvider(httpClient: getHttpClient()!);
    return _signInDataProvider;
  }

  static SignInRepository? getSignInRepository() {
    _signInRepository ??=
        SignInRepository(signInDataProvider: getSignInDataProvider()!);
    return _signInRepository;
  }
  
}