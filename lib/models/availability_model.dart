class AvailabilityModel {
  DateTime? date;
  List<Time>? time;

  AvailabilityModel({
    this.date,
    this.time,
  });

  factory AvailabilityModel.fromJson(Map<String, dynamic> json) =>
      AvailabilityModel(
          date: json["date"] == null ? null : DateTime.parse(json["date"]),
          time: json["time"] == null
              ? null
              : List<Time>.from(json["time"].map((x) => Time.fromJson(x))));
}

class Time {
  String? time;
  bool? booked;

  Time({
    this.time,
    this.booked,
  });

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        time: json["time"].toString(),
        booked: json["booked"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "booked": booked,
      };
}
