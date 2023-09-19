abstract class SignInEvent{}

class SigninEmailChanged extends SignInEvent {
  final String email;

  SigninEmailChanged({required this.email});
}

class SigninPasswordChanged extends SignInEvent {
  final String password;

  SigninPasswordChanged({required this.password});
}

class SigninEmailSubmitted extends SignInEvent {
  final String email;
  final String password;

  SigninEmailSubmitted({required this.email, required this.password});
}

class SigninWithGoogle extends SignInEvent {
  SigninWithGoogle();
}
