import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:tailorine_mobilev2/models/catalogue_model.dart';

class CatalogueProvider extends ChangeNotifier {
  List<CatalogueModel> _catalogue = [];
  List<CatalogueModel> get catalogue => _catalogue;
  set catalogue(List<CatalogueModel> catalogue) {
    _catalogue = catalogue;
    notifyListeners();
  }

  String baseUrl = 'https://glacial-headland-77864.herokuapp.com';

  Future<List<CatalogueModel>> getCatalogueByTailor(String uuid) async {
    var url = '$baseUrl/catalog?tailor=$uuid';
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    try {
      var data = jsonDecode(response.body)['data'];
      List<CatalogueModel> tailors = [];
      for (var item in data) {
        tailors.add(CatalogueModel.fromJson(item));
      }

      return tailors;
    } catch (e) {
      throw e;
    }
  }

  Future<CatalogueModel> getCatalogueDetail(String uuid) async {
    var url = '$baseUrl/catalog/$uuid';
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      CatalogueModel tailors = CatalogueModel.fromJson(data);
      return tailors;
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  //only upper
  Future<List<CatalogueModel>> getUpper(String uuid) async {
    var url = '$baseUrl/catalog?category=upper&tailor=$uuid';
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    try {
      var data = jsonDecode(response.body)['data'];
      List<CatalogueModel> tailors = [];
      for (var item in data) {
        tailors.add(CatalogueModel.fromJson(item));
      }

      return tailors;
    } catch (e) {
      return [];
    }
  }

  //only lower
  Future<List<CatalogueModel>> getLower(String uuid) async {
    var url = '$baseUrl/catalog?category=lower&tailor=$uuid';
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );
    try {
      var data = jsonDecode(response.body)['data'];
      List<CatalogueModel> tailors = [];
      for (var item in data) {
        tailors.add(CatalogueModel.fromJson(item));
      }

      return tailors;
    } catch (e) {
      return [];
    }
  }
}
