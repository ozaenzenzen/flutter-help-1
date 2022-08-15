/// Kelas model untuk mendefinisikan parameter-parameter request ke sendAppointment
///
/// Jika parameter tidak sesuai, bisa diganti variabel-variabel di bawah ini.
/// Dengan menggunakan kelas model, maka akan mengurangi boilerplate pada penulisan kode
class AppointmentRequestModel {
  final String? time;
  final String? date;
  final String? userCustomerId;
  final String? userTailorId;
  // final String? message;

  AppointmentRequestModel({
    this.time,
    this.date,
    this.userCustomerId,
    this.userTailorId,
    // this.message,
  });

  factory AppointmentRequestModel.fromJson(Map<String, dynamic> json) => AppointmentRequestModel(
        time: json['time'],
        date: json['date'],
        userCustomerId: json['user_customer_id'],
        userTailorId: json['user_tailor_id'],
        // message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "date": date,
        'user_customer_id': userCustomerId,
        'user_tailor_id': userTailorId,
        // "message": message,
      };
}
