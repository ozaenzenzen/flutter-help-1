import '../models/tailor_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TailorService {
  String baseUrl = 'https://glacial-headland-77864.herokuapp.com';

  Future<List<TailorModel>> getAllTailor() async {
    var url = '$baseUrl/tailor';
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      List<TailorModel> tailors = [];
      for (var item in data) {
        tailors.add(TailorModel.fromJson(item));
      }
      return tailors;
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<List<TailorModel>> getTailorPremium() async {
    var url = '$baseUrl/tailor?recommended';
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      List<TailorModel> tailors = [];
      for (var item in data) {
        tailors.add(TailorModel.fromJson(item));
      }
      return tailors;
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  Future<List<TailorModel>> getTailornonPremium() async {
    var url = '$baseUrl/tailor?premium=0&sort=rating&order=desc';
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      List<TailorModel> tailors = [];
      for (var item in data) {
        tailors.add(TailorModel.fromJson(item));
      }
      return tailors;
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }
}
