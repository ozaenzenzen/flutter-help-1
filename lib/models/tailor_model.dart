import 'package:tailorine_mobilev2/models/availability_model.dart';

class TailorModel {
  String? uuid;
  String? email;
  int? max_schedule_slot;
  bool? is_premium;
  int? user_tailor_id;
  String? rating;
  String? first_name;
  String? last_name;
  String? profile_picture;
  String? address;
  String? phone_number;
  String? speciality;
  String? city;
  String? district;
  String? province;
  String? zip_code;
  String? description;
  String? place_picture;
  List<AvailabilityDateTimeModel>? availability;

  TailorModel({
    this.uuid,
    this.email,
    this.max_schedule_slot,
    this.is_premium,
    this.user_tailor_id,
    this.rating,
    this.first_name,
    this.last_name,
    this.profile_picture,
    this.address,
    this.phone_number,
    this.speciality,
    this.city,
    this.district,
    this.province,
    this.zip_code,
    this.description,
    this.place_picture,
    this.availability,
  });

  factory TailorModel.fromJson(Map<String, dynamic> json) => TailorModel(
        uuid: json["uuid"],
        email: json["email"],
        max_schedule_slot: json["max_schedule_slot"],
        is_premium: json["is_premium"],
        user_tailor_id: json["user_tailor_id"],
        rating: json["rating"],
        first_name: json["first_name"],
        last_name: json["last_name"],
        profile_picture: json["profile_picture"],
        address: json["address"],
        phone_number: json["phone_number"],
        speciality: json["speciality"],
        city: json["city"],
        district: json["district"],
        province: json["province"],
        zip_code: json["zip_code"],
        description: json["description"],
        place_picture: json["place_picture"],
        availability: json["availability"] == null
            ? null
            : List<AvailabilityDateTimeModel>.from(
                json["availability"].map((x) => AvailabilityDateTimeModel.fromJson(x))),
      );
}


// class TailorModel {
//   String? uuid;
//   String? email;
//   int? max_schedule_slot;
//   bool? is_premium;
//   int? user_tailor_id;
//   String? rating;
//   String? first_name;
//   String? last_name;
//   String? profile_picture;
//   String? address;
//   String? phone_number;
//   String? speciality;
//   String? city;
//   String? district;
//   String? province;
//   String? zip_code;
//   String? description;
//   String? place_picture;
//   List<AvailabilityModel>? availability;

//   TailorModel({
//     this.uuid,
//     this.email,
//     this.max_schedule_slot,
//     this.is_premium,
//     this.user_tailor_id,
//     this.rating,
//     this.first_name,
//     this.last_name,
//     this.profile_picture,
//     this.address,
//     this.phone_number,
//     this.speciality,
//     this.city,
//     this.district,
//     this.province,
//     this.zip_code,
//     this.description,
//     this.place_picture,
//     this.availability,
//   });

//   factory TailorModel.fromJson(Map<String, dynamic> json) => TailorModel(
//         uuid: json["uuid"],
//         email: json["email"],
//         max_schedule_slot: json["max_schedule_slot"],
//         is_premium: json["is_premium"],
//         user_tailor_id: json["user_tailor_id"],
//         rating: json["rating"],
//         first_name: json["first_name"],
//         last_name: json["last_name"],
//         profile_picture: json["profile_picture"],
//         address: json["address"],
//         phone_number: json["phone_number"],
//         speciality: json["speciality"],
//         city: json["city"],
//         district: json["district"],
//         province: json["province"],
//         zip_code: json["zip_code"],
//         description: json["description"],
//         place_picture: json["place_picture"],
//         availability: json["availability"] == null
//             ? null
//             : List<AvailabilityModel>.from(
//                 json["availability"].map((x) => AvailabilityModel.fromJson(x))),
//       );
// }
