class UserResponseModel {
  UserResponseModel({
    this.meta,
    this.data,
  });

  UserMetaModel? meta;
  UserDataModel? data;

  factory UserResponseModel.fromJson(Map<String, dynamic> json) => UserResponseModel(
        meta: UserMetaModel.fromJson(json["meta"]),
        data: json["data"] != null ? UserDataModel.fromJson(json["data"]) : null,
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

class UserDataModel {
  UserDataModel({
    this.uuid,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.profile,
  });

  String? uuid;
  String? email;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserProfileModel? profile;

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        uuid: json["uuid"],
        email: json["email"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        profile: UserProfileModel.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid,
        "email": email,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "profile": profile?.toJson(),
      };
}

class UserProfileModel {
  UserProfileModel({
    this.firstName,
    this.lastName,
    this.profilePicture,
    this.address,
    this.district,
    this.city,
    this.province,
    this.zipCode,
    this.phoneNumber,
  });

  String? firstName;
  String? lastName;
  dynamic profilePicture;
  dynamic address;
  dynamic district;
  dynamic city;
  dynamic province;
  dynamic zipCode;
  dynamic phoneNumber;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
        firstName: json["first_name"],
        lastName: json["last_name"],
        profilePicture: json["profile_picture"],
        address: json["address"],
        district: json["district"],
        city: json["city"],
        province: json["province"],
        zipCode: json["zip_code"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "profile_picture": profilePicture,
        "address": address,
        "district": district,
        "city": city,
        "province": province,
        "zip_code": zipCode,
        "phone_number": phoneNumber,
      };
}

class UserMetaModel {
  UserMetaModel({
    this.code,
    this.status,
    this.message,
  });

  int? code;
  String? status;
  String? message;

  factory UserMetaModel.fromJson(Map<String, dynamic> json) => UserMetaModel(
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
