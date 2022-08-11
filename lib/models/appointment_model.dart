class AppointmentModel {
  String? message;
  String? time;
  String? date;
  String? phone_number;
  String? profile_picture;
  String? first_name;
  String? last_name;

  AppointmentModel({
    this.message,
    this.time,
    this.date,
    this.phone_number,
    this.profile_picture,
    this.first_name,
    this.last_name,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      message: json['message'].toString(),
      time: json['time'].toString(),
      date: json['date'].toString(),
      phone_number: json['phone_number'].toString(),
      profile_picture: json['profile_picture'].toString(),
      first_name: json['first_name'].toString(),
      last_name: json['last_name'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'time': time,
      'date': date,
      'phone_number': phone_number,
      'profile_picture': profile_picture,
      'first_name': first_name,
      'last_name': last_name,
    };
  }
}
