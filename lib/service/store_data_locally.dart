import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';
import 'dart:async';

class UserPreference {
  Future<bool> saveUserData(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('email', user.email!);
    prefs.setString('first_name', user.first_name!);
    prefs.setString('last_name', user.last_name!);
    prefs.setString('profile_picture', user.profile_picture!);
    prefs.setString('token', user.token!);
    return true;
  }

  Future<UserModel> getUser() async {
    var prefs = await SharedPreferences.getInstance();

    final email = prefs.getString('email') ?? "default@gmail.com";
    final first_name = prefs.getString('first_name') ?? "user";
    String uuid = prefs.getString('uuid') ?? "no uuid";
    String last_name = prefs.getString('last_name') ?? "default";
    String profile_picture = prefs.getString('profile_picture') ?? "";
    String token = prefs.getString('token') ?? "";
    return UserModel(
      email: email,
      uuid: uuid,
      first_name: first_name,
      last_name: last_name,
      profile_picture: profile_picture,
      token: token,
    );
  }

  // void removeUser() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();

  //   prefs.remove("name");
  //   prefs.remove("email");
  //   prefs.remove("phone");
  //   prefs.remove("type");
  //   prefs.remove("token");
  // }

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? "";
    return token;
  }

  Future<String> getUuid() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String uuid = prefs.getString('uuid') ?? "no uuid";
    return uuid;
  }
}
