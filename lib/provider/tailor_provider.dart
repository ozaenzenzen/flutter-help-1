import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:tailorine_mobilev2/models/tailor_modelV2.dart';
import 'package:tailorine_mobilev2/service/tailor_service.dart';

import '../models/tailor_model.dart';
import 'package:http/http.dart' as http;

enum CurrentState { Empty, Loading, Success, Error }

class TailorProvider with ChangeNotifier {
  List<TailorModel> _tailors = [];

  List<TailorModel> get tailors => _tailors;

  set products(List<TailorModel> products) {
    _tailors = tailors;
    notifyListeners();
  }

  // Future<void> getAllTailors() async {
  //   try {
  //     List<TailorModel> tailors = await TailorService().getTailorPremium();
  //     _tailors = tailors;
  //   } catch (error) {
  //     throw error;
  //   }
  // }
  String baseUrl = 'https://glacial-headland-77864.herokuapp.com';
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

  Future<TailorModel> getDetailTailor(String uuid) async {
    var url = '$baseUrl/tailor/$uuid';
    var headers = {'Content-Type': 'application/json'};
    var response = await http.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      return TailorModel.fromJson(data);
    } else {
      throw Exception(jsonDecode(response.body)['message']);
    }
  }

  CurrentState _currentState = CurrentState.Empty;
  CurrentState get currentState => _currentState;
  set currentState(CurrentState currentState) {
    _currentState = currentState;
    notifyListeners();
  }

  DetailTailorMetaModel _detailTailorMetaModel = DetailTailorMetaModel();
  DetailTailorMetaModel get detailTailorMetaModel => _detailTailorMetaModel;
  set detailTailorMetaModel(DetailTailorMetaModel detailTailorMetaModel) {
    _detailTailorMetaModel = detailTailorMetaModel;
    notifyListeners();
  }

  DetailTailorResponseModel _detailTailorResponseModel = DetailTailorResponseModel();
  DetailTailorResponseModel get detailTailorResponseModel => _detailTailorResponseModel;
  set detailTailorResponseModel(DetailTailorResponseModel detailTailorMetaModel) {
    _detailTailorResponseModel = detailTailorMetaModel;
    notifyListeners();
  }

  Future<void> getDetailTailorV2(String uuid) async {
    _currentState = CurrentState.Loading;
    notifyListeners();
    DetailTailorResponseModel detailTailorResp = await TailorService().getDetailTailor(uuid);
    if (detailTailorResp.meta?.code == 200) {
      _currentState = CurrentState.Success;
      _detailTailorResponseModel = detailTailorResp;
      notifyListeners();
    } else {
      _currentState = CurrentState.Error;
      _detailTailorMetaModel = detailTailorResp.meta!;
      notifyListeners();
    }
  }

  // Future getTailorsPremium() async {
  //   try {
  //     List<TailorModel> tailors = await TailorService().getTailorPremium();
  //     _tailors = tailors;
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Future<void> getTailorsnonPremium() async {
  //   try {
  //     List<TailorModel> tailors = await TailorService().getTailornonPremium();
  //     _tailors = tailors;
  //   } catch (e) {
  //     print(e);
  //   }
  // }

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
