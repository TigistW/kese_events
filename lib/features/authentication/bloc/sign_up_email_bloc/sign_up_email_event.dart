
import 'package:equatable/equatable.dart';
// part of 'sign_up_email_bloc.dart';

abstract class SignUpEmailEvent extends Equatable {
  const SignUpEmailEvent();

  @override
  List<Object> get props => [];
}

class SignUpUserWithEmail extends SignUpEmailEvent {
  String fullname;
  String email_address;
  String password;
  SignUpUserWithEmail({
    required this.fullname,
    required this.email_address,
    required this.password,
  });
}

class VerifyOtp extends SignUpEmailEvent {
  String email_address;
  String password;
  String OTP;
  VerifyOtp(
      {required this.email_address, required this.password, required this.OTP});
}
