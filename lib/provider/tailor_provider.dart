import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:tailorine_mobilev2/models/tailor_modelV2.dart';
import 'package:tailorine_mobilev2/service/tailor_service.dart';

import '../models/tailor_model.dart';
import 'package:http/http.dart' as http;

enum CurrentState { Empty, Loading, Success, Error }

class TailorProvider with ChangeNotifier {
  // List<TailorModel> _tailors = [];

  // List<TailorModel> get tailors => _tailors;

  // set products(List<TailorModel> products) {
  //   _tailors = tailors;
  //   notifyListeners();
  // }

  // Future<void> getAllTailors() async {
  //   try {
  //     List<TailorModel> tailors = await TailorService().getTailorPremium();
  //     _tailors = tailors;
  //   } catch (error) {
  //     throw error;
  //   }
  // }
  String baseUrl = 'https://glacial-headland-77864.herokuapp.com';

  CurrentState _tailorPremiumState = CurrentState.Empty;
  CurrentState get tailorPremiumState => _tailorPremiumState;
  set tailorPremiumState(CurrentState tailorPremiumState) {
    _tailorPremiumState = tailorPremiumState;
    notifyListeners();
  }

  TailorMetaModel _tailorPremiumMetaModel = TailorMetaModel();
  TailorMetaModel get tailorPremiumMetaModel => _tailorPremiumMetaModel;
  set tailorPremiumMetaModel(TailorMetaModel tailorPremiumMetaModel) {
    _tailorPremiumMetaModel = tailorPremiumMetaModel;
    notifyListeners();
  }

  TailorResponseModel _tailorPremiumResponseModel = TailorResponseModel();
  TailorResponseModel get tailorPremiumResponseModel => _tailorPremiumResponseModel;
  set tailorPremiumResponseModel(TailorResponseModel tailorResponseModelPremium) {
    _tailorPremiumResponseModel = tailorPremiumResponseModel;
    notifyListeners();
  }

  Future<void> getTailorPremiumV2() async {
    _tailorPremiumState = CurrentState.Loading;
    notifyListeners();
    TailorResponseModel tailorPremiumResp = await TailorService().getTailorPremium();
    if (tailorPremiumResp.meta?.code == 200) {
      _tailorPremiumState = CurrentState.Success;
      _tailorPremiumResponseModel = tailorPremiumResp;
      notifyListeners();
    } else {
      _tailorPremiumState = CurrentState.Error;
      _tailorPremiumMetaModel = tailorPremiumResp.meta!;
      notifyListeners();
    }
  }

  CurrentState _allTailorState = CurrentState.Empty;
  CurrentState get allTailorState => _allTailorState;
  set allTailorState(CurrentState allTailorState) {
    _allTailorState = allTailorState;
    notifyListeners();
  }

  TailorMetaModel _allTailorMetaModel = TailorMetaModel();
  TailorMetaModel get allTailorMetaModel => _allTailorMetaModel;
  set allTailorMetaModel(TailorMetaModel allTailorMetaModel) {
    _allTailorMetaModel = allTailorMetaModel;
    notifyListeners();
  }

  TailorResponseModel _allTailorResponseModel = TailorResponseModel();
  TailorResponseModel get allTailorResponseModel => _allTailorResponseModel;
  set allTailorResponseModel(TailorResponseModel allTailorResponseModel) {
    _allTailorResponseModel = allTailorResponseModel;
    notifyListeners();
  }

  Future<void> getAllTailor() async {
    _allTailorState = CurrentState.Loading;
    notifyListeners();
    try {
      TailorResponseModel allTailorResp = await TailorService().getAllTailor();
      if (allTailorResp.meta?.code == 200) {
        _allTailorState = CurrentState.Success;
        _allTailorResponseModel = allTailorResp;
        notifyListeners();
      } else {
        _allTailorState = CurrentState.Error;
        _allTailorMetaModel = allTailorResp.meta!;
        notifyListeners();
      }
    } catch (e) {
      _allTailorState = CurrentState.Error;
      _allTailorMetaModel = TailorMetaModel(code: 99, message: "$e", status: "error");

      notifyListeners();
    }
  }

  CurrentState _detailTailorState = CurrentState.Empty;
  CurrentState get detailTailorState => _detailTailorState;
  set detailTailorState(CurrentState currentState) {
    _detailTailorState = detailTailorState;
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
    _detailTailorState = CurrentState.Loading;
    notifyListeners();
    try {
      DetailTailorResponseModel detailTailorResp = await TailorService().getDetailTailor(uuid);
      if (detailTailorResp.meta?.code == 200) {
        _detailTailorState = CurrentState.Success;
        _detailTailorResponseModel = detailTailorResp;
        notifyListeners();
      } else {
        _detailTailorState = CurrentState.Error;
        _detailTailorMetaModel = detailTailorResp.meta!;
        notifyListeners();
      }
    } catch (e) {
      _tailorPremiumState = CurrentState.Error;
      _tailorPremiumMetaModel = TailorMetaModel(code: 99, message: "$e", status: "error");

      notifyListeners();
    }
  }

  TailorResponseModel _tailorNonPremiumResponseModel = TailorResponseModel();
  TailorResponseModel get tailorNonPremiumResponseModel => _tailorNonPremiumResponseModel;
  set tailorNonPremiumResponseModel(TailorResponseModel tailorNonPremiumResponseModel) {
    _tailorNonPremiumResponseModel = tailorNonPremiumResponseModel;
    notifyListeners();
  }

  TailorMetaModel _tailorNonPremiumMetaModel = TailorMetaModel();
  TailorMetaModel get tailorNonPremiumMetaModel => _tailorNonPremiumMetaModel;
  set tailorNonPremiumMetaModel(TailorMetaModel tailorNonPremiumMetaModel) {
    _tailorNonPremiumMetaModel = tailorNonPremiumMetaModel;
    notifyListeners();
  }

  CurrentState _tailorNonPremiumState = CurrentState.Empty;
  CurrentState get tailorNonPremiumState => _tailorNonPremiumState;
  set tailorNonPremiumState(CurrentState tailorNonPremiumState) {
    _tailorNonPremiumState = tailorNonPremiumState;
    notifyListeners();
  }

  Future<void> getTailornonPremiumV2() async {
    _tailorNonPremiumState = CurrentState.Loading;
    notifyListeners();
    try {
      TailorResponseModel _tailorRespNonPremium = await TailorService().getTailornonPremium();
      if (_tailorRespNonPremium.meta?.code == 200) {
        _tailorNonPremiumState = CurrentState.Success;
        _tailorNonPremiumResponseModel = _tailorRespNonPremium;
        notifyListeners();
      } else {
        _tailorNonPremiumState = CurrentState.Error;
        _tailorNonPremiumMetaModel = _tailorRespNonPremium.meta!;
        notifyListeners();
      }
    } catch (e) {
      _tailorNonPremiumState = CurrentState.Error;
      _tailorNonPremiumMetaModel = TailorMetaModel(code: 99, message: "$e", status: "error");

      notifyListeners();
    }
  }
}
