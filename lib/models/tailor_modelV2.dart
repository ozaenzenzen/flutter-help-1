class DetailTailorResponseModel {
  DetailTailorResponseModel({
    this.meta,
    this.data,
  });

  DetailTailorMetaModel? meta;
  DetailTailorDataModel? data;

  factory DetailTailorResponseModel.fromJson(Map<String, dynamic> json) => DetailTailorResponseModel(
        meta: DetailTailorMetaModel.fromJson(json["meta"]),
        data: DetailTailorDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> datameta = new Map<String, dynamic>();
    datameta["meta"] = meta?.toJson();
    if (this.data != null) {
      datameta["data"] = data?.toJson();
    }
    return datameta;
  }
}

class DetailTailorDataModel {
  DetailTailorDataModel({
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
    this.rating,
    this.profileId,
    this.availability,
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
  String? rating;
  int? profileId;
  List<Availability>? availability;

  factory DetailTailorDataModel.fromJson(Map<String, dynamic> json) => DetailTailorDataModel(
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
        rating: json["rating"],
        profileId: json["profile_id"],
        availability: List<Availability>.from(json["availability"].map((x) => Availability.fromJson(x))),
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
        "rating": rating,
        "profile_id": profileId,
        "availability": List<dynamic>.from(availability!.map((x) => x.toJson())),
      };
}

class Availability {
  Availability({
    this.date,
    this.time,
  });

  DateTime? date;
  List<String>? time;

  factory Availability.fromJson(Map<String, dynamic> json) => Availability(
        date: DateTime.parse(json["date"]),
        time: List<String>.from(json["time"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "time": List<dynamic>.from(time!.map((x) => x)),
      };
}

class DetailTailorMetaModel {
  DetailTailorMetaModel({
    this.code,
    this.status,
    this.message,
  });

  int? code;
  String? status;
  String? message;

  factory DetailTailorMetaModel.fromJson(Map<String, dynamic> json) => DetailTailorMetaModel(
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
