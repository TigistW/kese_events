import 'package:kese_events/features/profile/data_provider/profile_dataprovider.dart';
import 'package:kese_events/models/user/user.dart';

class UserProfileRepository {
  final ProfileDataProvider profileDataProvider;

  UserProfileRepository({required this.profileDataProvider});

  Future<User> profile() async {
    print("in profile repository");
    return await profileDataProvider.get_user_profile();
  }
}
