import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailorine_mobilev2/models/appointment_model.dart';

import '../service/appointment_service.dart';

class AppointmentProvider with ChangeNotifier {
  AppointmentModel _appointment = AppointmentModel();

  AppointmentModel get appointment => _appointment;

  set appointment(AppointmentModel appointment) {
    _appointment = appointment;
    notifyListeners();
  }

  Future<bool> sendAppointment({
    String? message,
    String? time,
    String? date,
    String? phone_number,
    String? profile_picture,
  }) async {
    try {
      AppointmentModel appointment = await AppointmentService().sendAppointment(
        message: message,
        time: time,
        date: date,
        phone_number: phone_number,
        profile_picture: profile_picture,
      );

      _appointment = appointment;
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}


//   Future