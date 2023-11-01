
import 'package:hive/hive.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:kese_events/models/user/user.dart';

class ProfileHiveProvider {
  String _userBoxName = 'User';
  Future<Box> userBox() async {
    var box = await Hive.openBox(_userBoxName);
    return box;
  }

  Future<void> setUser(User userProfile) async {
    final box = await userBox();
    await box.put("user", userProfile);
  }

  Future<bool> userExists() async {
    final box = await userBox();
    return box.containsKey("user");
  }

  Future<User> getUser() async {
    final box = await userBox();
    User user_profile = await box.get("user");
    return user_profile;
  }

  Future<void> deleteUser() async {
    final box = await userBox();
    await box.clear();
  }
}
