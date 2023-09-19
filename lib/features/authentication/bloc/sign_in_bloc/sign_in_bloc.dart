import 'dart:convert';

import 'package:kese_events/core/utils/form_submission_state.dart';
import 'package:kese_events/features/authentication/bloc/sign_in_bloc/sign_in_event.dart';
import 'package:kese_events/features/authentication/bloc/sign_in_bloc/sign_in_state.dart';
import 'package:kese_events/features/authentication/repository/sign_in_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInRepository signInRepository;
  SignInBloc(
      {required this.signInRepository})
      : super(SignInState()) {
    
    
    on<SigninEmailChanged>(
      (event, emit) {
        emit(state.copyWith(email: event.email));
      },
    );
    
    on<SigninPasswordChanged>(
      (event, emit) {
        emit(state.copyWith(password: event.password));
      },
    );

    on<SigninEmailSubmitted>(
      (event, emit) async {
        emit(state.copyWith(formState: FormSubmitting()));
        try {
          await signInRepository.signInEmail(
              email: event.email, password: event.password);
          // final token = jsonDecode(response) as Map<String, dynamic>;

          emit(state.copyWith(formState: SubmissionSuccess()));
        } catch (e) {
          emit(state.copyWith(formState: SubmissionFailed(Exception(e))));
        }
      },
    );
    
    
    
    
    }}