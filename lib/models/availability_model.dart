class AvailabilityResponseModel {
    AvailabilityResponseModel({
        this.meta,
        this.data,
    });

    AvailabilityMetaModel? meta;
    List<AvailabilityDateTimeModel>? data;

    factory AvailabilityResponseModel.fromJson(Map<String, dynamic> json) => AvailabilityResponseModel(
        meta: AvailabilityMetaModel.fromJson(json["meta"]),
        data: List<AvailabilityDateTimeModel>.from(json["data"].map((x) => AvailabilityDateTimeModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "meta": meta?.toJson(),
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class AvailabilityMetaModel {
    AvailabilityMetaModel({
        this.code,
        this.status,
        this.message,
    });

    int? code;
    String? status;
    String? message;

    factory AvailabilityMetaModel.fromJson(Map<String, dynamic> json) => AvailabilityMetaModel(
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

class AvailabilityDateTimeModel {
    AvailabilityDateTimeModel({
        this.date,
        this.time,
    });

    DateTime? date;
    List<AvailabilityTimeModel>? time;

    factory AvailabilityDateTimeModel.fromJson(Map<String, dynamic> json) => AvailabilityDateTimeModel(
        date: DateTime.parse(json["date"]),
        time: List<AvailabilityTimeModel>.from(json["time"].map((x) => AvailabilityTimeModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "time": List<dynamic>.from(time!.map((x) => x.toJson())),
    };
}

class AvailabilityTimeModel {
    AvailabilityTimeModel({
        this.time,
        this.booked,
    });

    String? time;
    bool? booked;

    factory AvailabilityTimeModel.fromJson(Map<String, dynamic> json) => AvailabilityTimeModel(
        time: json["time"],
        booked: json["booked"],
    );

    Map<String, dynamic> toJson() => {
        "time": time,
        "booked": booked,
    };
}



// class AvailabilityModel {
//   DateTime? date;
//   List<Time>? time;

//   AvailabilityModel({
//     this.date,
//     this.time,
//   });

//   Map<String, dynamic> toJson() => {
//         "date": date,
//         "time": time,
//       };

//   factory AvailabilityModel.fromJson(Map<String, dynamic> json) =>
//       AvailabilityModel(
//           date: json["date"] == null ? null : DateTime.parse(json["date"]),
//           time: json["time"] == null
//               ? null
//               : List<Time>.from(json["time"].map((x) => Time.fromJson(x))));
// }

// class Time {
//   String? time;
//   bool? booked;

//   Time({
//     this.time,
//     this.booked,
//   });

//   factory Time.fromJson(Map<String, dynamic> json) => Time(
//         time: json["time"].toString(),
//         booked: json["booked"],
//       );

//   Map<String, dynamic> toJson() => {
//         "time": time,
//         "booked": booked,
//       };
// }
