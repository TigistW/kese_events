
import 'package:equatable/equatable.dart';

// part of 'sign_up_email_bloc.dart';

enum UserStatus {
  Unkown,
  OldUser,
  NewUser,
}

abstract class SignUpEmailState extends Equatable {
  SignUpEmailState();

  @override
  List<Object> get props => [];

  get password => null;
  get email_address => null;
}

class SignUpEmailInitial extends SignUpEmailState {}

class SignUpEmailLoading extends SignUpEmailState {
  String firstName;
  String lastName;
  @override
  String email_address;
  @override
  String password;
  UserStatus user_status;
  String message = "";

  SignUpEmailLoading({
    required this.firstName,
    required this.lastName,
    required this.email_address,
    required this.password,
    this.user_status = UserStatus.Unkown,
    this.message = "waiting",
  });

  @override
  List<Object> get props => [
        this.firstName,
        this.lastName,
        this.email_address,
        this.password,
        this.user_status
      ];
}

class SignUpEmailWaitForOTP extends SignUpEmailState {
  String firstName;
  String lastName;
  @override
  String email_address;
  @override
  String password;
  UserStatus user_status;
  String message;

  SignUpEmailWaitForOTP({
    required this.firstName,
    required this.lastName,
    required this.email_address,
    required this.password,
    this.user_status = UserStatus.NewUser,
    this.message = "Waiting for OTP",
  });

  @override
  List<Object> get props => [
        this.firstName,
        this.lastName,
        this.email_address,
        this.password,
        this.user_status
      ];
}

class SignUpEmailAlreadyExists extends SignUpEmailState {
  @override
  String email_address;
  UserStatus user_status;

  SignUpEmailAlreadyExists({
    required this.email_address,
    this.user_status = UserStatus.OldUser,
  });

  @override
  List<Object> get props => [this.email_address, this.user_status];
}

class SignUpEmailVerifyOTPInitial extends SignUpEmailState {
  @override
  String email_address;
  @override
  String password;
  SignUpEmailVerifyOTPInitial({
    required this.email_address,
    required this.password,
  });

  @override
  List<Object> get props => [this.email_address, this.password];
}

class SignUpEmailVerifyOTPWaiting extends SignUpEmailState {}

class SignUpEmailInvalidOTP extends SignUpEmailState {
  @override
  String email_address;
  @override
  String password;
  String message;
  SignUpEmailInvalidOTP(
      {required this.email_address,
      required this.password,
      required this.message});

  @override
  List<Object> get props => [this.email_address, this.password];
}

class SignUpEmailOTPVerifySuccess extends SignUpEmailState {
  @override
  String email_address;
  @override
  String password;
  String message;
  SignUpEmailOTPVerifySuccess(
      {required this.email_address,
      required this.password,
      required this.message});

  @override
  List<Object> get props => [this.email_address, this.password];
}

class SignUpEmailError extends SignUpEmailState {
  String message = "";
  SignUpEmailError({required this.message});
}
