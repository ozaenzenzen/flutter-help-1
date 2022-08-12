import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tailorine_mobilev2/models/appoinment_req_model.dart';
import 'package:tailorine_mobilev2/models/appointment_model.dart';
import 'package:tailorine_mobilev2/models/availability_model.dart';

import '../service/appointment_service.dart';

enum CurrentState { Empty, Loading, Success, Error }

class AppointmentProvider with ChangeNotifier {
  AvailabilityMetaModel _availabilityMetaModel = AvailabilityMetaModel();
  AvailabilityMetaModel get availabilityMetaModel => _availabilityMetaModel;
  set availabilityMetaModel(AvailabilityMetaModel availabilityMetaModel) {
    _availabilityMetaModel = availabilityMetaModel;
    notifyListeners();
  }

  List<AvailabilityDateTimeModel> _listAvailability = [];
  List<AvailabilityDateTimeModel> get listAvailability => _listAvailability;
  set listAvailability(List<AvailabilityDateTimeModel> listAvailability) {
    _listAvailability = listAvailability;
    notifyListeners();
  }

  List<AvailabilityDateTimeModel> _selectedList = [];
  List<AvailabilityDateTimeModel> get selectedList => _selectedList;
  set selectedList(List<AvailabilityDateTimeModel> selectedList) {
    _selectedList = selectedList;
    notifyListeners();
  }

  List<AvailabilityTimeModel> _listAvailabilityTime = [];
  List<AvailabilityTimeModel> get listAvailabilityTime => _listAvailabilityTime;
  set listAvailabilityTime(List<AvailabilityTimeModel> listAvailabilityTime) {
    _listAvailabilityTime = listAvailabilityTime;
    notifyListeners();
  }

  bool? _isLoading = false;
  bool? get isLoading => _isLoading;
  set isLoading(bool? isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }

  CurrentState _currentState = CurrentState.Empty;
  CurrentState get currentState => _currentState;
  set currentState(CurrentState currentState) {
    _currentState = currentState;
    notifyListeners();
  }

  String _message = '';
  String get message => _message;

  void chooseAvailability(DateTime date) {
    selectedList = [];
    listAvailabilityTime = [];

    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    debugPrint("data formattedDate: ${formattedDate}");

    _selectedList = listAvailability.where((e) {
      String formattedDate2 = DateFormat('yyyy-MM-dd').format(e.date!);
      return formattedDate2 == formattedDate;
    }).toList();

    debugPrint("_selectedList ${_selectedList}");

    for (final element in _selectedList) {
      for (final element2 in element.time!) {
        _listAvailabilityTime.add(element2);
      }
    }
  }

  Future<void> fetchAvailability(String uuid) async {
    listAvailability.clear();
    _currentState = CurrentState.Loading;
    notifyListeners();
    AvailabilityResponseModel? availabilityResp = await AppointmentService().fetchAvailabilityV2(uuid);
    if (availabilityResp?.meta?.code == 200) {
      _currentState = CurrentState.Success;
      availabilityResp?.data?.forEach((element) {
        listAvailability.add(element);
      });
      notifyListeners();
    } else {
      _currentState = CurrentState.Error;
      availabilityMetaModel = availabilityResp!.meta!;
      notifyListeners();
    }
  }

  AppointmentMetaModel _appointmentMetaModel = AppointmentMetaModel();
  AppointmentMetaModel get appointmentMetaModel => _appointmentMetaModel;
  set appointmentMetaModel(AppointmentMetaModel appointmentMetaModel) {
    _appointmentMetaModel = appointmentMetaModel;
    notifyListeners();
  }

  AppointmentResponseModel _appointmentResponseModel = AppointmentResponseModel();
  AppointmentResponseModel get appointmentResponseModel => _appointmentResponseModel;
  set appointmentResponseModel(AppointmentResponseModel appointmentResponseModel) {
    _appointmentResponseModel = appointmentResponseModel;
    notifyListeners();
  }

  Future<void> sendAppointment(AppointmentRequestModel? appointmentRequestModel) async {
    _currentState = CurrentState.Loading;
    notifyListeners();
    AppointmentResponseModel? appointmentResp = await AppointmentService().sendAppointment(
      appointmentRequestModel: appointmentRequestModel!,
    );
    if (appointmentResp?.meta?.code == 200) {
      _currentState = CurrentState.Success;
      _appointmentResponseModel = appointmentResp!;
      notifyListeners();
    } else {
      _currentState = CurrentState.Error;
      appointmentMetaModel = appointmentResp!.meta!;
      notifyListeners();
    }
  }
}

// AppointmentModel _appointment = AppointmentModel();
// AppointmentModel get appointment => _appointment;
// set appointment(AppointmentModel appointment) {
//   _appointment = appointment;
//   notifyListeners();
// }

//   Future<bool> sendAppointment({
//     String? message,
//     String? time,
//     String? date,
//     String? phone_number,
//     String? profile_picture,
//   }) async {
//     try {
//       AppointmentModel appointment = await AppointmentService().sendAppointment(
//         message: message,
//         time: time,
//         date: date,
//         phone_number: phone_number,
//         profile_picture: profile_picture,
//       );

//       _appointment = appointment;
//       return true;
//     } catch (e) {
//       print(e);
//       return false;
//     }
//   }
// }

//   Future
