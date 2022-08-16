import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tailorine_mobilev2/models/user_modelV2.dart';
import 'package:tailorine_mobilev2/screens/settings/detail_edit_password.dart';
import 'package:tailorine_mobilev2/service/store_data_locally.dart';
import 'package:tailorine_mobilev2/service/tailor_service.dart';
import '../models/user_model.dart';
import '../service/auth_service.dart';

enum AuthState { Empty, Loading, Success, Error }

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

  AuthState _userProfileState = AuthState.Empty;
  AuthState get userProfileState => _userProfileState;
  set userProfileState(AuthState userProfileState) {
    _userProfileState = userProfileState;
    notifyListeners();
  }

  UserMetaModel _userMetaModel = UserMetaModel();
  UserMetaModel get userMetaModel => _userMetaModel;
  set userMetaModel(UserMetaModel userMetaModel) {
    _userMetaModel = userMetaModel;
    notifyListeners();
  }

  UserResponseModel _userResponseModel = UserResponseModel();
  UserResponseModel get userResponseModel => _userResponseModel;
  set userResponseModel(UserResponseModel userResponseModel) {
    _userResponseModel = userResponseModel;
    notifyListeners();
  }

  Future<void> getProfileV2() async {
    _userProfileState = AuthState.Loading;
    notifyListeners();
    UserResponseModel _getProfileResp = await AuthService().getProfileV2();
    if (_getProfileResp.meta?.code == 200) {
      _userProfileState = AuthState.Success;
      _userResponseModel = _getProfileResp;
      notifyListeners();
    } else {
      _userProfileState = AuthState.Error;
      _userMetaModel = _getProfileResp.meta!;
      notifyListeners();
    }
  }
}
