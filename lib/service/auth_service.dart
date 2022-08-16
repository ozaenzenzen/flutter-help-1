import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailorine_mobilev2/models/user_modelV2.dart';
import 'package:tailorine_mobilev2/service/store_data_locally.dart';

import '../models/user_model.dart';

class AuthService {
  // String baseUrl = 'http://10.0.2.2:8000';
  String baseUrl = 'https://glacial-headland-77864.herokuapp.com';

  Future<UserModel> register({
    String? first_name,
    String? last_name,
    String? email,
    String? password,
    String? city,
    String? address,
    String? province,
    String? zip_code,
    String? district,
  }) async {
    var url = '$baseUrl/customer/register';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'password': password,
      'city': city,
      'address': address,
      'province': province,
      'zip_code': zip_code,
      'district': district,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']['profile']);
      user.token = 'Bearer ' + data['access_token'];
      user.uuid = data['user']['uuid'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', user.email!);
      prefs.setString('uuid', user.uuid!);
      prefs.setString('password', user.password!);
      prefs.setString('token', user.token!);
      prefs.setString('first_name', user.first_name!);
      prefs.setString('last_name', user.last_name!);
      prefs.setString('profile_picture', user.profile_picture!);
      prefs.setBool("isLoggedIn", true);
      print(prefs.setString('uuid', user.uuid!));
      print(prefs.getString('uuid'));
      print(prefs.getString('token'));
      return user;
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<UserModel> login({
    String? email,
    String? password,
  }) async {
    var url = '$baseUrl/customer/login';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'email': email,
      'password': password,
    });
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['user']['profile']);
      user.uuid = data['user']['uuid'];
      user.token = 'Bearer ' + data['access_token'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', user.token!);
      prefs.setString('uuid', user.uuid!);
      print(prefs.getString('uuid'));
      print(prefs.getString('token'));

      UserPreference().saveUserData(user);
      return user;
    } else {
      return jsonDecode(response.body)['message'];
    }
  }

  //make logout
  Future logout() async {
    var url = '$baseUrl/customer/logout';
    String getToken = await UserPreference().getToken();
    var headers = {
      'Content-Type': 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $getToken"
    };
    var response = await http.post(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final sharedPreferences = await SharedPreferences.getInstance();
      if (sharedPreferences.getString('token') != null) {
        sharedPreferences.remove('token');
      } else {
        throw Exception('No token found');
      }
    }
  }

  //forgot password
  Future<UserModel> forgotPassword({
    String? email,
  }) async {
    var url = '$baseUrl/customer/forgot-password';
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({
      'email': email,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    // print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return data;
    } else {
      throw Exception('wlee');
    }
  }

//update profile
  Future<UserModel> updateProfile({
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
    String? phone_number,
    String? old_password,
    String? password_confirmation,
  }) async {
    String uuid = await UserPreference().getUuid();

    var url = '$baseUrl/customer/$uuid';
    String getToken = await UserPreference().getToken();

    var headers = {
      'Content-Type': 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $getToken"
    };
    var body = jsonEncode({
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'city': city,
      'address': address,
      'province': province,
      'zip_code': zip_code,
      'district': district,
      'phone_number': phone_number,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    try {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['profile']);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('first_name', user.first_name!);
      prefs.setString('last_name', user.last_name!);
      prefs.setString('profile_picture', user.profile_picture!);
      prefs.setString('city', user.city!);
      prefs.setString('address', user.address!);
      prefs.setString('province', user.province!);
      prefs.setString('zip_code', user.zip_code!);
      prefs.setString('district', user.district!);
      prefs.setString('phone_number', user.phone_number!);

      return user;
    } catch (e) {
      throw Exception(e);
    }
  }

  //change profile pict
  Future upload(File imageFile) async {
    var stream = http.ByteStream(imageFile.openRead());
    stream.cast();
    var length = await imageFile.length();
    String uuid = await UserPreference().getUuid();
    var uri = Uri.parse("$baseUrl/customer/$uuid");
    var request = http.MultipartRequest("POST", uri);
    var multipartFile = http.MultipartFile('profile_picture', stream, length,
        filename: basename(imageFile.path));
    String getToken = await UserPreference().getToken();
    request.headers.addAll({
      'Content-Type': 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $getToken"
    });
    request.files.add(multipartFile);
    var response = await request.send();
    print(getToken);
    if (response.statusCode == 200) {
      print('uploaded');
    } else {
      print('failed');
    }

    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  //change password
  Future<UserModel> updatePassword({
    String? password,
    String? old_password,
    String? password_confirmation,
  }) async {
    String uuid = await UserPreference().getUuid();
    print(uuid);
    var url = '$baseUrl/customer/$uuid';
    String getToken = await UserPreference().getToken();

    var headers = {
      'Content-Type': 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $getToken"
    };
    var body = jsonEncode({
      'password': password,
      'old_password': old_password,
      'password_confirmation': password_confirmation,
    });

    var response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    try {
      var data = jsonDecode(response.body)['data'];
      UserModel user = UserModel.fromJson(data['profile']);

      return user;
    } catch (e) {
      throw Exception(e);
    }
  }

  //get profile
  Future<UserModel> getProfile() async {
    String uuid = await UserPreference().getUuid();
    print(uuid);

    var url = '$baseUrl/customer/$uuid';
    String getToken = await UserPreference().getToken();
    print(getToken);
    var headers = {
      'Content-Type': 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $getToken"
    };
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    try {
      // var data = jsonDecode(response.body)['data'];
      // UserModel user = UserModel.fromJson(data['profile']);

      debugPrint("getProfile: ${jsonDecode(response.body)['data']['profile']}");

      UserModel user = UserModel.fromJson(jsonDecode(response.body)['data']['profile']);
      print(response.body);

      return user;
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  //get profile
  Future<UserResponseModel> getProfileV2() async {
    String uuid = await UserPreference().getUuid();
    String getToken = await UserPreference().getToken();
     try {
      var url = '$baseUrl/customer/$uuid';
      var headers = {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: "Bearer $getToken",
      };
      var response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      var jsonData = jsonDecode(response.body);
      debugPrint("[AuthService][getProfileV2] jsonData $jsonData");
      return UserResponseModel.fromJson(jsonData);
    } catch (e) {
      return UserResponseModel.fromJson(
        {
          "meta": {
            'status': 'error',
            'message': '$e',
          },
          // "data": [],
        },
      );
    }
  }
}
