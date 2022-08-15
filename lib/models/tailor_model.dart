// import 'package:tailorine_mobilev2/models/availability_model.dart';

class TailorResponseModel {
    TailorResponseModel({
        this.meta,
        this.data,
    });

    TailorMetaModel? meta;
    List<TailorDataModel>? data;

    factory TailorResponseModel.fromJson(Map<String, dynamic> json) => TailorResponseModel(
        meta: TailorMetaModel.fromJson(json["meta"]),
        data: List<TailorDataModel>.from(json["data"].map((x) => TailorDataModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class TailorDataModel {
    TailorDataModel({
        this.uuid,
        this.email,
        this.maxScheduleSlot,
        this.transactionId,
        this.isPremium,
        this.isReady,
        this.userTailorId,
        this.firstName,
        this.lastName,
        this.profilePicture,
        this.placePicture,
        this.description,
        this.address,
        this.district,
        this.city,
        this.province,
        this.zipCode,
        this.phoneNumber,
        this.profileId,
        this.rating,
        this.totalReview,
    });

    String? uuid;
    String? email;
    int? maxScheduleSlot;
    dynamic? transactionId;
    bool? isPremium;
    bool? isReady;
    int? userTailorId;
    String? firstName;
    String? lastName;
    String? profilePicture;
    String? placePicture;
    String? description;
    String? address;
    String? district;
    String? city;
    String? province;
    String? zipCode;
    String? phoneNumber;
    int? profileId;
    dynamic? rating;
    int? totalReview;

    factory TailorDataModel.fromJson(Map<String, dynamic> json) => TailorDataModel(
        uuid: json["uuid"],
        email: json["email"],
        maxScheduleSlot: json["max_schedule_slot"],
        transactionId: json["transaction_id"],
        isPremium: json["is_premium"],
        isReady: json["is_ready"],
        userTailorId: json["user_tailor_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        profilePicture: json["profile_picture"],
        placePicture: json["place_picture"],
        description: json["description"],
        address: json["address"],
        district: json["district"],
        city: json["city"],
        province: json["province"],
        zipCode: json["zip_code"],
        phoneNumber: json["phone_number"],
        profileId: json["profile_id"],
        rating: json["rating"],
        totalReview: json["total_review"],
    );

    Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "email": email,
        "max_schedule_slot": maxScheduleSlot,
        "transaction_id": transactionId,
        "is_premium": isPremium,
        "is_ready": isReady,
        "user_tailor_id": userTailorId,
        "first_name": firstName,
        "last_name": lastName,
        "profile_picture": profilePicture,
        "place_picture": placePicture,
        "description": description,
        "address": address,
        "district": district,
        "city": city,
        "province": province,
        "zip_code": zipCode,
        "phone_number": phoneNumber,
        "profile_id": profileId,
        "rating": rating,
        "total_review": totalReview,
    };
}

class TailorMetaModel {
    TailorMetaModel({
        this.code,
        this.status,
        this.message,
    });

    int? code;
    String? status;
    String? message;

    factory TailorMetaModel.fromJson(Map<String, dynamic> json) => TailorMetaModel(
        code: json["code"],
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
    };
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
//   List<AvailabilityDateTimeModel>? availability;

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
//             : List<AvailabilityDateTimeModel>.from(
//                 json["availability"].map((x) => AvailabilityDateTimeModel.fromJson(x))),
//       );
// }


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
