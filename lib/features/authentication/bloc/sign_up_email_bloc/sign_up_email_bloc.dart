import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:kese_events/features/authentication/bloc/sign_up_email_bloc/sign_up_email_event.dart';
import 'package:kese_events/features/authentication/bloc/sign_up_email_bloc/sign_up_email_state.dart';
import 'package:kese_events/features/authentication/repository/sign_up_email_repository.dart';
import 'package:kese_events/features/notification/notification_cubit/notification_cubit.dart';

Future<bool> checkEmail() async {
  await Future<void>.delayed(Duration(milliseconds: 500));
  return false;
}

Future<bool> signUpUser() async {
  await Future<void>.delayed(Duration(milliseconds: 500));
  return false;
}

class SignUpEmailBloc extends Bloc<SignUpEmailEvent, SignUpEmailState> {
  final SignUpEmailRepository signUpEmailRepository;
  final NotificationCubit notificationCubit;
  SignUpEmailBloc(
      {required this.signUpEmailRepository, required this.notificationCubit})
      : super(SignUpEmailInitial()) {
    on<SignUpEmailEvent>((event, emit) async {
      if (event is SignUpUserWithEmail) {
        emit(
          SignUpEmailLoading(
            firstName: event.firstName,
            lastName: event.lastName,
            email_address: event.email_address,
            password: event.password
          ),
        );
        try {
          Map<String, dynamic> res = await signUpEmailRepository
              .check_email_exists(email_address: event.email_address);

              if (res['message'] == "Email already exists") {
                notificationCubit.errorNotification(message: res['message']);
                emit(SignUpEmailAlreadyExists(
                  email_address: event.email_address,
                )
                );
            emit(SignUpEmailDataRetained(
                firstName: event.firstName,
                lastName: event.lastName,
                email_address: event.email_address,
                password: event.password,
              ));
        return;
          }
        } catch (e) {
          emit(SignUpEmailError(message: e.toString()));
          notificationCubit.errorNotification(message: "Error Signing Up");
          return;
        }
        try {
          Map<String, dynamic> response = await signUpEmailRepository.signUpWithEmail(
            firstName: event.firstName,
            lastName: event.lastName,
            emailAddress: event.email_address,
            password: event.password,
            confirm_password: event.confirm_password
          );

          print("]]]]]]]]]]]]]]]]]]]]]]]]]]]]");
          print(response);

          

          if (response.containsKey('statusCode') &&
              response['statusCode'] == 201) {
            emit(SignUpEmailVerifyOTPInitial(
              email_address: event.email_address,
              password: event.password,
            ));
          } else {
            
            notificationCubit.errorNotification(
                message: response['message']);
            emit(SignUpEmailError(
                message: response.containsKey('message')
                    ? response['message']
                    : "UnkownError"));
          }
        } catch (e) {
          print("here");
           print(e.toString());
           print("...........................................");
          emit(SignUpEmailError(message: e.toString()));
          notificationCubit.errorNotification(message: "Error signing up user, please try again.");
          return;
        }
      }
    });
    on<VerifyOtp>((event, emit) async {
      print(event.email_address);
      /**
       * Work Flow
       * before we got here the form has to be validated
       * try to verify the user inside try catch
       * if anything happend go back to otp initial state from the data
       * we get at the event
       */
      emit(SignUpEmailVerifyOTPWaiting());
      try {
        Map<String, dynamic> res = await signUpEmailRepository.verifyEmailOTP(
            emailAddress: event.email_address, otp: event.OTP);
        print(res.isNotEmpty);
        print(res);
        if (res.containsKey('statusCode') && res['statusCode'] == 200) {
          emit(SignUpEmailOTPVerifySuccess(
              email_address: event.email_address,
              password: event.password,
              message: res['message'])
              // message:res.toString())
              );
          return;
        } else if (res.containsKey('statusCode') &&
            res['statusCode'] == 400 &&
            res['message'] == "User is already Verified") {
          emit(SignUpEmailOTPVerifySuccess(
              email_address: event.email_address,
              password: event.password,
              message: res['message']));
          return;
        } else {
          emit(
            SignUpEmailInvalidOTP(
                email_address: event.email_address,
                password: event.password,
                message: res.containsKey('message')
                    ? res['message']
                    : "Wrong verification code"),
          );
          return;
        }
      } catch (e) {
        print(e.toString());
        emit(SignUpEmailInvalidOTP(
            email_address: event.email_address,
            password: event.password,
            message: "Internal Server Error"));
        return;
      }
    });
  }
}
