
import 'package:kese_events/features/profile/data_provider/profile_hive_dataprovider.dart';
import 'package:kese_events/models/user/user.dart';

class UserHiveRepository {

  final ProfileHiveProvider profileHiveProvider;

  UserHiveRepository({required this.profileHiveProvider});

  Future<void> saveUser(User userProfile) async {
    profileHiveProvider.setUser(userProfile);
  }

  Future<bool> userExists() async {
    return profileHiveProvider.userExists();
  }

  Future<User> getUser() async {
    return profileHiveProvider.getUser();
  }

  Future <void> deleteUser() async {
    profileHiveProvider.deleteUser();
  }
  
}
