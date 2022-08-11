import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tailorine_mobilev2/screens/settings/detail_edit_password.dart';
import 'package:tailorine_mobilev2/service/store_data_locally.dart';
import '../models/user_model.dart';
import '../service/auth_service.dart';

class AuthProvider with ChangeNotifier {
  UserModel _user = UserModel(
    uuid: '',
    email: 'default',
    password: 'user pass',
    token: '',
  );

  UserModel get user => _user;

  set user(UserModel user) {
    _user = user;
    UserPreference().getUser();
    notifyListeners();
  }

  Future<bool> register({
    String? first_name,
    String? last_name,
    String? email,
    String? password,
    String? city,
    String? address,
    String? province,
    String? zip_code,
    String? district,
    String? token,
  }) async {
    try {
      UserModel user = await AuthService().register(
        // username: username,
        first_name: first_name,
        last_name: last_name,
        email: email,
        password: password,
        city: city,
        address: address,
        province: province,
        zip_code: zip_code,
        district: district,
      );

      _user = user;
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> login({
    String? email,
    String? password,
  }) async {
    try {
      UserModel user = await AuthService().login(
        email: email,
        password: password,
      );
      UserPreference().getUser();

      _user = user;

      return true;
    } catch (error) {
      // print(error.toString());

      return false;
    }
  }

  Future<bool> logout() async {
    try {
      await AuthService().logout();

      _user = UserModel(
        uuid: '',
        email: '',
        password: '',
        token: '',
      );

      return true;
    } catch (error) {
      print(error.toString());

      return false;
    }
  }

  //forgot password
  Future<bool> forgotPassword({
    String? email,
  }) async {
    try {
      await AuthService().forgotPassword(
        email: email,
      );

      _user = user;

      return true;
    } catch (error) {
      print(error.toString());

      return false;
    }
  }

  //edit profile
  Future<bool> editProfile({
    String? first_name,
    String? uuid,
    String? last_name,
    String? email,
    String? password,
    String? city,
    String? address,
    String? province,
    String? zip_code,
    String? district,
    String? phone_number,
    String? token,
  }) async {
    try {
      UserModel user = await AuthService().updateProfile(
        first_name: first_name,
        last_name: last_name,
        email: email,
        password: password,
        city: city,
        address: address,
        province: province,
        zip_code: zip_code,
        district: district,
        token: token,
        phone_number: phone_number,
      );

      _user = user;

      return true;
    } catch (error) {
      print(error);

      return false;
    }
  }

  //change profile pic

  Future<bool> editPassword({
    String? password,
    String? old_password,
    String? password_confirmation,
  }) async {
    try {
      UserModel user = await AuthService().updatePassword(
        password: password,
        old_password: old_password,
        password_confirmation: password_confirmation,
      );

      _user = user;

      return true;
    } catch (error) {
      print(error);

      return false;
    }
  }

  //send appointment

}
