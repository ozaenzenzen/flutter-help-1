import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailorine_mobilev2/models/user_model.dart';
import 'package:tailorine_mobilev2/provider/auth_provider.dart';
import 'package:tailorine_mobilev2/service/auth_service.dart';
import 'package:tailorine_mobilev2/widget/loading_button.dart';
import '../../service/store_data_locally.dart';
import '../../shared/theme.dart';

class DetailEditProfile extends StatefulWidget {
  @override
  State<DetailEditProfile> createState() => _DetailEditProfileState();
}

class _DetailEditProfileState extends State<DetailEditProfile> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();

  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController districtController = TextEditingController();

  bool isLoading = false;
  File? image;
  String baseUrl = 'https://glacial-headland-77864.herokuapp.com';

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('failed to pick image : ${e}');
    }
  }

  upload(File imageFile) async {
    var stream = http.ByteStream(imageFile.openRead());
    stream.cast();
    var length = await imageFile.length();
    String uuid = await UserPreference().getUuid();
    var uri = Uri.parse("$baseUrl/customer/$uuid");
    var request = http.MultipartRequest("POST", uri);
    var multipartFile = http.MultipartFile('profile_picture', stream, length,
        filename: path.basename(imageFile.path));
    String getToken = await UserPreference().getToken();
    request.headers.addAll({
      'Content-Type': 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $getToken"
    });
    request.files.add(multipartFile);
    // send request to upload image
    await request.send().then((response) async {
      // listen for response
      response.stream.transform(utf8.decoder).listen((value) {
        print(value);
        setState(() {
          if (response.statusCode == 200) {
            print('uploaded');
          } else {
            print('failed');
          }
        });
        // Hide loader
      });
    }).catchError((e) {
      print(e);
      // Hide loader
    });
  }

  @override
  void initState() {
    super.initState();
    stickUserData();
  }

  void stickUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var first_name = prefs.getString('first_name');
    var email = prefs.getString('email');
    var last_name = prefs.getString('last_name');
    var profile_picture = prefs.getString('profile_picture');
    var city = prefs.getString('city');
    var address = prefs.getString('address');
    var province = prefs.getString('province');
    var zip_code = prefs.getString('zip_code');
    var district = prefs.getString('district');
    var phone_number = prefs.getString('phone_number');

    if (first_name != null &&
        last_name != null &&
        profile_picture != null &&
        city != null &&
        address != null &&
        province != null &&
        zip_code != null &&
        district != null &&
        phone_number != null) {
      Provider.of<AuthProvider>(context, listen: false).user = UserModel(
        first_name: first_name,
        email: email!,
        profile_picture: profile_picture,
        last_name: last_name,
        city: city,
        address: address,
        province: province,
        zip_code: zip_code,
        district: district,
        phone_number: phone_number,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    handleEditProfilPicture() async {
      if (image == null) {
        return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 3),
            backgroundColor: successColor,
            content: Text(
              'No image selected',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
      setState(() {
        isLoading = true;
      });
      await upload(image!);
      setState(() {
        isLoading = false;
      });
    }

    handleEditData() async {
      setState(() {
        isLoading = true;
      });
      if (await authProvider.editProfile(
        first_name: firstnameController.text,
        last_name: lastnameController.text,
        phone_number: phonenumberController.text,
        address: addressController.text,
        city: cityController.text,
        province: provinceController.text,
        zip_code: postalCodeController.text,
        district: districtController.text,
        // profile_picture: ,
      )) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 3),
            backgroundColor: successColor,
            content: Text(
              'Profil kamu berhasil di perbarui',
              textAlign: TextAlign.center,
            ),
          ),
        );
        Navigator.pushNamed(context, '/main');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 3),
            backgroundColor: errorColor,
            content: Text(
              'Terjadi kesalahan, coba lagi',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
      setState(() {
        isLoading = false;
      });
    }

    Widget header() {
      return Padding(
        padding: const EdgeInsets.only(
          right: 24,
          left: 24,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: WillPopScope(
                  onWillPop: () async {
                    bool willLeave = false;
                    // show the confirm dialog
                    await showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: const Text(
                                  'Jika kamu keluar maka data tidak akan tersimpan'),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    willLeave = true;
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Ya'),
                                ),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text('Tidak'),
                                )
                              ],
                            ));
                    return willLeave;
                  },
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Image.asset(
                      'assets/icons/back.png',
                      width: 32,
                      height: 32,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                ),
                child: Text(
                  'Edit Profil',
                  style: titleTextStyle.copyWith(
                      fontSize: 20, fontWeight: semibold),
                ),
              ),
              const SizedBox(
                width: 24,
              ),
            ],
          )
        ]),
      );
    }

    Widget profilPhoto() {
      return Padding(
        padding: EdgeInsets.only(top: 30),
        child: Column(
          children: [
            // user.profile_picture != null
            //     ? CircleAvatar(
            //         radius: 50,
            //         backgroundImage: NetworkImage(
            //           user.profile_picture!,
            //         ),
            //       )
            //     : Icon(
            //         Icons.person,
            //         size: 50,
            //       ),
            image != null
                ? ClipOval(
                    child: Image.file(
                      image!,
                      width: 150,
                      height: 150,
                    ),
                  )
                : Icon(
                    Icons.person,
                    size: 50,
                  ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () {
                pickImage();
              },
              child: Text(
                'Ubah foto profil',
                style: regularTextStyle.copyWith(
                    fontWeight: bold, fontSize: 14, color: primaryColor),
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      );
    }

    Widget infoProfil() {
      return Padding(
        padding: const EdgeInsets.only(left: 24.0),
        child: Text(
          'Info Profil',
          style: regularTextStyle.copyWith(fontSize: 18, fontWeight: bold),
        ),
      );
    }

    Widget nameInput() {
      return Container(
        margin: EdgeInsets.only(top: 16, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama depan',
              style: regularTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: textColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 17,
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    Expanded(
                      child: TextFormField(
                        style: regularTextStyle,
                        controller: firstnameController,
                        decoration: InputDecoration.collapsed(
                          hintText: user.first_name!,
                          hintStyle: regularTextStyle.copyWith(
                              fontSize: 14, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget lastnameInput() {
      return Container(
        margin: EdgeInsets.only(top: 20, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Belakang',
              style: regularTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: textColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      size: 17,
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    Expanded(
                      child: TextFormField(
                        style: regularTextStyle,
                        controller: lastnameController,
                        decoration: InputDecoration.collapsed(
                          hintText: user.last_name!,
                          hintStyle: regularTextStyle.copyWith(
                              fontSize: 14, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget phonenumberInput() {
      return Container(
        margin: EdgeInsets.only(top: 20, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nomor handphone',
              style: regularTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: textColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Row(
                  children: [
                    Icon(
                      Icons.phone_android_rounded,
                      size: 17,
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    Expanded(
                      child: TextFormField(
                        style: regularTextStyle,
                        controller: phonenumberController,
                        decoration: InputDecoration.collapsed(
                          hintText: user.phone_number ??
                              'Masukkan nomor handphone kamu',
                          hintStyle: regularTextStyle.copyWith(
                              fontSize: 14, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget infoAlamat() {
      return Padding(
        padding: const EdgeInsets.only(left: 24.0, top: 30),
        child: Text(
          'Info Alamat',
          style: regularTextStyle.copyWith(fontSize: 18, fontWeight: bold),
        ),
      );
    }

    Widget addressInput() {
      return Container(
        margin: EdgeInsets.only(top: 20, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alamat tempat tinggal',
              style: regularTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: textColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      size: 17,
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    Expanded(
                      child: TextFormField(
                        style: regularTextStyle,
                        controller: addressController,
                        decoration: InputDecoration.collapsed(
                          hintText: user.address ?? 'Masukkan alamat kamu',
                          hintStyle: regularTextStyle.copyWith(
                              fontSize: 14, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget cityInput() {
      return Container(
        margin: EdgeInsets.only(top: 20, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kota',
              style: regularTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: textColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Row(
                  children: [
                    Icon(
                      Icons.location_city_rounded,
                      size: 17,
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    Expanded(
                      child: TextFormField(
                        style: regularTextStyle,
                        controller: cityController,
                        decoration: InputDecoration.collapsed(
                          hintText: user.city ?? 'Masukkan kota kamu',
                          hintStyle: regularTextStyle.copyWith(
                              fontSize: 14, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget districtInput() {
      return Container(
        margin: EdgeInsets.only(top: 20, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kecamatan',
              style: regularTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: textColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Row(
                  children: [
                    Icon(
                      Icons.location_city_rounded,
                      size: 17,
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    Expanded(
                      child: TextFormField(
                        style: regularTextStyle,
                        controller: districtController,
                        decoration: InputDecoration.collapsed(
                          hintText: user.district ?? 'Masukkan kecamatan kamu',
                          hintStyle: regularTextStyle.copyWith(
                              fontSize: 14, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget provinceInput() {
      return Container(
        margin: EdgeInsets.only(top: 20, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Provinsi',
              style: regularTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: textColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      size: 17,
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    Expanded(
                      child: TextFormField(
                        style: regularTextStyle,
                        controller: provinceController,
                        decoration: InputDecoration.collapsed(
                          hintText: user.province ?? 'Masukkan Provinsi kamu',
                          hintStyle: regularTextStyle.copyWith(
                              fontSize: 14, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget zipcodeInput() {
      return Container(
        margin: EdgeInsets.only(top: 20, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kode Pos',
              style: regularTextStyle.copyWith(
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Container(
              height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: textColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Row(
                  children: [
                    Icon(
                      Icons.code_rounded,
                      size: 17,
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    Expanded(
                      child: TextFormField(
                        style: regularTextStyle,
                        controller: postalCodeController,
                        decoration: InputDecoration.collapsed(
                          hintText: user.zip_code ?? 'Masukkan kode pos kamu',
                          hintStyle: regularTextStyle.copyWith(
                              fontSize: 14, color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget saveButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: 30, right: 24, left: 24, bottom: 18),
        child: TextButton(
          onPressed: () async {
            handleEditData();
            handleEditProfilPicture();
          },
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Simpan',
            style: regularTextStyle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: bgColor,
            ),
          ),
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        bool willLeave = false;
        await showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title:
                const Text('Jika kamu keluar maka data tidak akan tersimpan'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  willLeave = true;
                  Navigator.of(context).pop();
                },
                child: const Text('Ya'),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Tidak'))
            ],
          ),
        );
        return willLeave;
      },
      child: Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: ListView(
            children: [
              header(),
              profilPhoto(),
              infoProfil(),
              nameInput(),
              lastnameInput(),
              phonenumberInput(),
              infoAlamat(),
              addressInput(),
              cityInput(),
              districtInput(),
              provinceInput(),
              zipcodeInput(),
              isLoading
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: 24.0, right: 24, bottom: 30),
                      child: LoadingButton(),
                    )
                  : saveButton(),
            ],
          ),
        ),
      ),
    );
  }
}
