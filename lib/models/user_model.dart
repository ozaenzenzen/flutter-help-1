class UserModel {
  String? uuid;
  String? first_name;
  String? last_name;
  String? password;
  String? old_password;
  String? password_confirmation;
  String? email;
  String? profile_picture;
  String? address;
  String? phone_number;
  String? token;
  String? city;
  String? district;
  String? province;
  String? zip_code;

  UserModel({
    this.uuid,
    this.first_name,
    this.last_name,
    this.email,
    this.profile_picture,
    this.address,
    this.phone_number,
    this.token,
    this.password,
    this.city,
    this.district,
    this.province,
    this.zip_code,
    this.old_password,
    this.password_confirmation,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      password: json['password'].toString(),
      uuid: json['uuid'].toString(),
      first_name: json['first_name'].toString(),
      last_name: json['last_name'].toString(),
      address: json['address'].toString(),
      email: json['email'].toString(),
      profile_picture: json['profile_picture'].toString(),
      phone_number: json['phone_number'].toString(),
      token: json['token'].toString(),
      city: json['city'].toString(),
      district: json['district'].toString(),
      province: json['province'].toString(),
      zip_code: json['zip_code'].toString(),
      old_password: json['old_password'].toString(),
      password_confirmation: json['password_confirmation'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'first_name': first_name,
      'last_name': last_name,
      'email': email,
      'password': password,
      'address': address,
      'phone_number': phone_number,
      'profile_picture': profile_picture,
      'token': token,
      'city': city,
      'district': district,
      'province': province,
      'zip_code': zip_code,
      'old_password': old_password,
      'password_confirmation': password_confirmation,
    };
  }
}
