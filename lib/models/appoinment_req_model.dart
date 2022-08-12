class AppointmentRequestModel {
  final String? message;
  final String? time;
  final String? date;
  final String? phone_number;
  final String? profile_picture;
  final String? first_name;
  final String? last_name;

  AppointmentRequestModel({
    this.message,
    this.time,
    this.date,
    this.phone_number,
    this.profile_picture,
    this.first_name,
    this.last_name,
  });

  factory AppointmentRequestModel.fromJson(Map<String, dynamic> json) => AppointmentRequestModel(
        message: json['message'],
        time: json['time'],
        date: json['date'],
        phone_number: json['phone_number'],
        profile_picture: json['profile_picture'],
        first_name: json['first_name'],
        last_name: json['last_name'],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "time": time,
        "date": date,
        "phone_number": phone_number,
        "profile_picture": profile_picture,
        "first_name": first_name,
        "last_name": last_name,
      };
}
