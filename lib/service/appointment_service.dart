import 'dart:convert';
import 'dart:io';

import 'package:tailorine_mobilev2/service/store_data_locally.dart';

import '../models/appointment_model.dart';
import 'package:http/http.dart' as http;

import '../models/availability_model.dart';

class AppointmentService {
  String baseUrl = 'https://glacial-headland-77864.herokuapp.com';

  Future<AppointmentModel> sendAppointment({
    String? message,
    String? time,
    String? date,
    String? phone_number,
    String? profile_picture,
    String? first_name,
    String? last_name,
  }) async {
    //  var url = '$baseUrl/customer/register';
    try {
      AppointmentModel appointment = await AppointmentModel(
        message: message,
        time: time,
        date: date,
        phone_number: phone_number,
        profile_picture: profile_picture,
      );

      return appointment;
    } catch (e) {
      throw Exception(e);
    }
  }

  // fetch availability
  Future<List<AvailabilityModel>> fetchAvailability(String uuid) async {
    String getToken = await UserPreference().getToken();
    try {
      var url = '$baseUrl/availability?tailor=$uuid';
      var headers = {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: "Bearer $getToken"
      };
      var response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'] as List;
        List<AvailabilityModel> availability = [];
        for (var item in data) {
          availability.add(AvailabilityModel.fromJson(item));
        }
        return availability.toList();
      } else {
        throw Exception(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //fetch availability

}
