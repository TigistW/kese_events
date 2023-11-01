
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kese_events/core/utils/form_submission_state.dart';
import 'package:kese_events/features/authentication/bloc/secure_storage.dart';
import 'package:kese_events/features/authentication/bloc/sign_in_bloc/sign_in_event.dart';
import 'package:kese_events/features/authentication/bloc/sign_in_bloc/sign_in_state.dart';
import 'package:kese_events/features/authentication/repository/sign_in_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kese_events/features/profile/repository/user_hive_repository.dart';
import 'package:kese_events/features/profile/repository/user_profile_repository.dart';
import 'package:kese_events/models/user/user.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInRepository signInRepository;
  final UserProfileRepository userProfileRepository;
  final UserHiveRepository userHiveRepository;
  SignInBloc(
      {required this.signInRepository, required this.userProfileRepository, required this.userHiveRepository})
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
          final response = await signInRepository.signInEmail(
              email: event.email, password: event.password);
          print("iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
          print(response);
        SecureStorage _secureStorage = SecureStorage();
        final token = jsonDecode(response) as Map<String, dynamic>;
        await _secureStorage.persistEmailAndToken(
              event.email, token['data']['token']);
        // getting user profile from the backend
          User profile = await userProfileRepository.profile();

          await userHiveRepository.saveUser(profile);

          print("yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy");
          User user = await userHiveRepository.getUser();
          print(user.email);


          emit(state.copyWith(formState: SubmissionSuccess()));
        } catch (e) {
          emit(state.copyWith(formState: SubmissionFailed(Exception(e))));
        }
      },
    );

    }}