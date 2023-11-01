import 'package:http/http.dart' as http;
import 'package:kese_events/config.dart';
import 'package:kese_events/features/authentication/bloc/sign_up_email_bloc/sign_up_email_bloc.dart';
import 'package:kese_events/features/authentication/data_provider/sign_in_data_provider.dart';
import 'package:kese_events/features/authentication/data_provider/sign_up_email_data_provider.dart';
import 'package:kese_events/features/authentication/repository/sign_in_repository.dart';
import 'package:kese_events/features/authentication/repository/sign_up_email_repository.dart';
import 'package:kese_events/features/event/dataprovider/event_dataprovider.dart';
import 'package:kese_events/features/event/dataprovider/tag_dataprovider.dart';
import 'package:kese_events/features/event/repository/event_repository.dart';
import 'package:kese_events/features/event/repository/tag_repository.dart';
import 'package:kese_events/features/notification/notification_cubit/notification_cubit.dart';
import 'package:kese_events/features/payment/data_provider/payment_dataprovider.dart';
import 'package:kese_events/features/payment/repository/payment_repository.dart';
import 'package:kese_events/features/profile/data_provider/profile_dataprovider.dart';
import 'package:kese_events/features/profile/data_provider/profile_hive_dataprovider.dart';
import 'package:kese_events/features/profile/repository/user_hive_repository.dart';
import 'package:kese_events/features/profile/repository/user_profile_repository.dart';

class DependencyInjector {
  static http.Client? _httpClient;
  static AppConfig? _config;
  static SignInDataProvider? _signInDataProvider;
  static SignInRepository? _signInRepository;

  static SignUpEmailDataProvider? _signUpEmailProvider;
  static SignUpEmailRepository? _signUpEmailRepository;

  // notification Cubit
  static NotificationCubit? _notificationCubit;

  // event
  static EventRepository? _eventRepository;
  static EventDataProvider? _eventDataProvider;
  
//tag

  static TagRepository? _tagRepository;
  static TagDataProvider? _tagDataProvider;

//payment

  static PaymentRepository? _paymentRepository;
  static PaymentDataProvider? _paymentDataProvider;

// profile and hive

  static UserProfileRepository? _userProfileRepository;
  static ProfileDataProvider? _profileDataProvider;

  static UserHiveRepository? _userHiveRepository;
  static ProfileHiveProvider? _userHiveProvider;
  
// 

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
    _signUpEmailProvider ??=
        SignUpEmailDataProvider(httpClient: getHttpClient()!);
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

  // Events
  static EventDataProvider? getEventProvider() {
    _eventDataProvider ??= EventDataProvider(getHttpClient()!);
    return _eventDataProvider;
  }

  static EventRepository? getEventRepository() {
    _eventRepository ??= EventRepository(getEventProvider()!);
    return _eventRepository;
  }

  //Tags
  static TagDataProvider? getTagProvider() {
    _tagDataProvider ??= TagDataProvider(getHttpClient()!);
    return _tagDataProvider;
  }

  static TagRepository? getTagRepository() {
    _tagRepository ??= TagRepository(getTagProvider()!);
    return _tagRepository;
  }

  //Payments
  static PaymentDataProvider? getPaymentProvider() {
    _paymentDataProvider ??= PaymentDataProvider(getHttpClient()!);
    return _paymentDataProvider;
  }

  static PaymentRepository? getPaymentRepository() {
    _paymentRepository ??= PaymentRepository(getPaymentProvider()!);
    return _paymentRepository;
  }

    // profile
  static ProfileDataProvider? getProfileDataProvider() {
    _profileDataProvider ??= ProfileDataProvider(httpClient: getHttpClient()!);
    return _profileDataProvider;
  }

  static UserProfileRepository? getProfileRepository() {
    _userProfileRepository ??=
        UserProfileRepository(profileDataProvider: getProfileDataProvider()!);
    return _userProfileRepository;
  }

    // user profile cache data
  static ProfileHiveProvider? getProfileHiveProvider() {
    _userHiveProvider ??= ProfileHiveProvider();
    return _userHiveProvider;
  }

  static UserHiveRepository? getUserHiveRepository() {
    _userHiveRepository ??= UserHiveRepository(profileHiveProvider: ProfileHiveProvider()!);
    return _userHiveRepository;
  }

}
