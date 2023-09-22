

import 'package:kese_events/features/authentication/data_provider/sign_up_email_data_provider.dart';

class SignUpEmailRepository {
  final SignUpEmailDataProvider sign_up_email_dataprovider;
  // SignUpEmailRepository();
  SignUpEmailRepository({required this.sign_up_email_dataprovider});
  Future<Map<String, dynamic>> check_email_exists(
      
      {required String email_address}) async {
    return await sign_up_email_dataprovider.checkEmail(email_address);
  }

  Future<Map<String, dynamic>> signUpWithEmail({
    required String fullname,
    required String emailAddress,
    required String password,
  }) async {
    return await sign_up_email_dataprovider.signUpUserWithEmail(
        fullname: fullname,
        emailAddress: emailAddress,
        password: password);
  }

  Future<Map<String, dynamic>> verifyEmailOTP(
      {required String emailAddress, required String otp}) async {
    return await sign_up_email_dataprovider.verifyOTP(
      emailAddress: emailAddress,
      otp: otp,
    );
  }
}