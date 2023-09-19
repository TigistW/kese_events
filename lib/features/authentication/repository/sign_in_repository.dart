import 'package:kese_events/features/authentication/data_provider/data_provider.dart';

class SignInRepository {
  final SignInDataProvider signInDataProvider;

  SignInRepository({required this.signInDataProvider});

  Future<String> signInEmail({
    required String email,
    required String password,
  }) async {
    return await signInDataProvider.signInEmail(
        email: email, password: password);
  }
}
