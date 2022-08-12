class AppointmentResponseModel {
  AppointmentResponseModel({
    this.meta,
    this.data,
  });

  AppointmentMetaModel? meta;
  AppointmentDataModel? data;

  factory AppointmentResponseModel.fromJson(Map<String, dynamic> json) => AppointmentResponseModel(
        meta: AppointmentMetaModel.fromJson(json["meta"]),
        data: AppointmentDataModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": data?.toJson(),
      };
}

class AppointmentDataModel {
  AppointmentDataModel({
    this.accessToken,
    this.tokenType,
    this.user,
  });

  String? accessToken;
  String? tokenType;
  AppointmentUserModel? user;

  factory AppointmentDataModel.fromJson(Map<String, dynamic> json) => AppointmentDataModel(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        user: AppointmentUserModel.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken!,
        "token_type": tokenType!,
        "user": user?.toJson(),
      };
}

class AppointmentUserModel {
  AppointmentUserModel({
    this.id,
    this.email,
    this.profile,
  });

  int? id;
  String? email;
  AppointmentProfileModel? profile;

  factory AppointmentUserModel.fromJson(Map<String, dynamic> json) => AppointmentUserModel(
        id: json["id"],
        email: json["email"],
        profile: AppointmentProfileModel.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "profile": profile?.toJson(),
      };
}

class AppointmentProfileModel {
  AppointmentProfileModel({
    this.firstName,
    this.lastName,
    this.profilePicture,
    this.address,
    this.phoneNumber,
  });

  String? firstName;
  String? lastName;
  String? profilePicture;
  String? address;
  dynamic phoneNumber;

  factory AppointmentProfileModel.fromJson(Map<String, dynamic> json) => AppointmentProfileModel(
        firstName: json["first_name"],
        lastName: json["last_name"],
        profilePicture: json["profile_picture"],
        address: json["address"],
        phoneNumber: json["phone_number"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "profile_picture": profilePicture,
        "address": address,
        "phone_number": phoneNumber,
      };
}

class AppointmentMetaModel {
  AppointmentMetaModel({
    this.code,
    this.status,
    this.message,
  });

  int? code;
  String? status;
  String? message;

  factory AppointmentMetaModel.fromJson(Map<String, dynamic> json) => AppointmentMetaModel(
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


// class AppointmentModel {
//   String? message;
//   String? time;
//   String? date;
//   String? phone_number;
//   String? profile_picture;
//   String? first_name;
//   String? last_name;

//   AppointmentModel({
//     this.message,
//     this.time,
//     this.date,
//     this.phone_number,
//     this.profile_picture,
//     this.first_name,
//     this.last_name,
//   });

//   factory AppointmentModel.fromJson(Map<String, dynamic> json) {
//     return AppointmentModel(
//       message: json['message'].toString(),
//       time: json['time'].toString(),
//       date: json['date'].toString(),
//       phone_number: json['phone_number'].toString(),
//       profile_picture: json['profile_picture'].toString(),
//       first_name: json['first_name'].toString(),
//       last_name: json['last_name'].toString(),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'message': message,
//       'time': time,
//       'date': date,
//       'phone_number': phone_number,
//       'profile_picture': profile_picture,
//       'first_name': first_name,
//       'last_name': last_name,
//     };
//   }
// }
