import 'package:equatable/equatable.dart';
import 'package:kese_events/core/utils/form_submission_state.dart';
import 'package:kese_events/core/utils/validators.dart';

class SignInState extends Equatable{
  final Validators _validators = Validators();
  final String email;
  String? get isValidEmail => _validators.validateName(email);
  final String password;
  String? get isValidPassword => _validators.validateName(password);
  final FormSubmissionState formState;

    SignInState({
    this.email = '',
    this.password = '',
    this.formState = const InitialFormStatus(),
  });

  SignInState copyWith({
    String? email,
    String? password,
    FormSubmissionState? formState,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      formState: formState ?? this.formState,
    );
  }

  @override
  List<Object?> get props =>
      [this.email,this.password, this.formState];

}