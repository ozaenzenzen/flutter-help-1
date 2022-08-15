/// Kelas model untuk mendefinisikan parameter-parameter request ke sendAppointment
///
/// Jika parameter tidak sesuai, bisa diganti variabel-variabel di bawah ini.
/// Dengan menggunakan kelas model, maka akan mengurangi boilerplate pada penulisan kode
class AppointmentRequestModel {
  final String? time;
  final String? date;
  final String? userTailorId;
  // final String? userCustomerId;
  // final String? message;

  AppointmentRequestModel({
    this.time,
    this.date,
    this.userTailorId,
    // this.userCustomerId,
    // this.message,
  });

  factory AppointmentRequestModel.fromJson(Map<String, dynamic> json) => AppointmentRequestModel(
        time: json['time'],
        date: json['date'],
        userTailorId: json['user_tailor_id'],
        // userCustomerId: json['user_customer_id'],
        // message: json['message'],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "date": date,
        'user_tailor_id': userTailorId,
        // 'user_customer_id': userCustomerId,
        // "message": message,
      };
}
