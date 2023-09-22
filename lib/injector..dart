import 'package:http/http.dart' as http;
import 'package:kese_events/config.dart';
import 'package:kese_events/features/authentication/bloc/sign_up_email_bloc/sign_up_email_bloc.dart';
import 'package:kese_events/features/authentication/data_provider/sign_in_data_provider.dart';
import 'package:kese_events/features/authentication/data_provider/sign_up_email_data_provider.dart';
import 'package:kese_events/features/authentication/repository/sign_in_repository.dart';
import 'package:kese_events/features/authentication/repository/sign_up_email_repository.dart';
import 'package:kese_events/features/notification/notification_cubit/notification_cubit.dart';
class DependencyInjector {
  static http.Client? _httpClient;
  static AppConfig? _config;
  static SignInDataProvider? _signInDataProvider;
  static SignInRepository? _signInRepository;

  static SignUpEmailDataProvider? _signUpEmailProvider;
  static SignUpEmailRepository? _signUpEmailRepository;

    // notification Cubit
  static NotificationCubit? _notificationCubit;



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

  static SignUpEmailDataProvider? getSignUpEmailDataProvider() {
    _signUpEmailProvider ??= SignUpEmailDataProvider(httpClient: getHttpClient()!);
    return _signUpEmailProvider;
  }

  static SignUpEmailRepository? getSignUpEmailRepository() {
    _signUpEmailRepository ??= SignUpEmailRepository(
        sign_up_email_dataprovider: getSignUpEmailDataProvider()!);
    return _signUpEmailRepository;
  }

  static NotificationCubit? getNotificationCubit() {
    _notificationCubit ??= NotificationCubit();
    return _notificationCubit;
  }

  
  
}