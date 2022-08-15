import 'package:tailorine_mobilev2/models/tailor_modelV2.dart';

import '../models/tailor_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TailorService {
  String baseUrl = 'https://glacial-headland-77864.herokuapp.com';

  Future<TailorResponseModel> getAllTailor() async {
    try {
      var url = '$baseUrl/tailor';
      var headers = {'Content-Type': 'application/json'};
      var response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      var jsonData = jsonDecode(response.body);
      return TailorResponseModel.fromJson(jsonData);
    } catch (e) {
      return TailorResponseModel.fromJson(
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

  Future<DetailTailorResponseModel> getDetailTailor(String uuid) async {
    try {
      var url = '$baseUrl/tailor/$uuid';
      var headers = {'Content-Type': 'application/json'};
      var response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      var jsonData = jsonDecode(response.body);
      return DetailTailorResponseModel.fromJson(jsonData);
    } catch (e) {
      return DetailTailorResponseModel.fromJson(
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

  Future<TailorResponseModel> getTailorPremium() async {
    try {
      var url = '$baseUrl/tailor?recommended';
      var headers = {'Content-Type': 'application/json'};
      var response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      var jsonData = jsonDecode(response.body);
      return TailorResponseModel.fromJson(jsonData);
    } catch (e) {
      return TailorResponseModel.fromJson(
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

  Future<TailorResponseModel> getTailornonPremium() async {
    try {
      var url = '$baseUrl/tailor?premium=0&sort=rating&order=desc';
      var headers = {'Content-Type': 'application/json'};
      var response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      var jsonData = jsonDecode(response.body);
      return TailorResponseModel.fromJson(jsonData);
    } catch (e) {
      return TailorResponseModel.fromJson(
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
