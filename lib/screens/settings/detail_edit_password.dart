import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/auth_provider.dart';
import '../../shared/theme.dart';
import '../../widget/loading_button.dart';

class EditPassword extends StatefulWidget {
  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  bool isLoading = false;

  bool isHide = true;
  bool isHide1 = true;
  bool isHide2 = true;
  void _obscurePass() {
    setState(() {
      isHide = !isHide;
    });
  }

  void _obscurePass1() {
    setState(() {
      isHide1 = !isHide1;
    });
  }

  void _obscurePass2() {
    setState(() {
      isHide2 = !isHide2;
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleEditPassword() async {
      setState(() {
        isLoading = true;
      });
      if (await authProvider.editPassword(
          old_password: currentPasswordController.text,
          password: newPasswordController.text,
          password_confirmation: confirmPasswordController.text)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 3),
            backgroundColor: successColor,
            content: Text(
              'Password kamu berhasil di perbarui',
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
              'Password yang kamu masukkan salah',
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Image.asset(
                  'assets/icons/back.png',
                  width: 32,
                  height: 32,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
              ),
              child: Text(
                'Ubah Password',
                style:
                    titleTextStyle.copyWith(fontSize: 20, fontWeight: semibold),
              ),
            ),
            const SizedBox(
              width: 24,
            ),
          ],
        ),
      );
    }

    Widget oldPasswordInput() {
      return Container(
        margin: EdgeInsets.only(top: 20, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password lama kamu',
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
                border: Border.all(
                  color: textColor,
                  width: 1,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Row(
                  children: [
                    Icon(
                      Icons.lock,
                      size: 17,
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    Expanded(
                      child: TextFormField(
                        style: regularTextStyle,
                        obscureText: isHide,
                        controller: currentPasswordController,
                        decoration: InputDecoration(
                          hintText: 'Masukkan password lama kamu',
                          hintStyle: regularTextStyle.copyWith(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isHide ? Icons.visibility : Icons.visibility_off,
                              color: textColor,
                            ),
                            onPressed: () {
                              _obscurePass();
                            },
                          ),
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

    Widget newPasswordInput() {
      return Container(
        margin: EdgeInsets.only(top: 20, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password baru kamu',
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
                border: Border.all(
                  color: textColor,
                  width: 1,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Row(
                  children: [
                    Icon(
                      Icons.lock,
                      size: 17,
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    Expanded(
                      child: TextFormField(
                        style: regularTextStyle,
                        obscureText: isHide1,
                        controller: newPasswordController,
                        decoration: InputDecoration(
                          hintText: 'Masukkan password baru kamu',
                          hintStyle: regularTextStyle.copyWith(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isHide1 ? Icons.visibility : Icons.visibility_off,
                              color: textColor,
                            ),
                            onPressed: () {
                              _obscurePass1();
                            },
                          ),
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

    Widget confirmationPasswordInput() {
      return Container(
        margin: EdgeInsets.only(top: 20, left: 24, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Konfirmasi password baru',
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
                border: Border.all(
                  color: textColor,
                  width: 1,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Row(
                  children: [
                    Icon(
                      Icons.lock,
                      size: 17,
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    Expanded(
                      child: TextFormField(
                        style: regularTextStyle,
                        obscureText: isHide2,
                        controller: confirmPasswordController,
                        decoration: InputDecoration(
                          hintText: 'Masukkan ulang password kamu',
                          hintStyle: regularTextStyle.copyWith(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isHide2 ? Icons.visibility : Icons.visibility_off,
                              color: textColor,
                            ),
                            onPressed: () {
                              _obscurePass2();
                            },
                          ),
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

    Widget passwordCaution() {
      return Padding(
        padding: const EdgeInsets.only(left: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Password harus terdiri dari kombinasi huruf dan angka',
              style: regularTextStyle.copyWith(
                color: Colors.grey,
                fontSize: 16,
              ),
            )
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
          onPressed: () {
            handleEditPassword();
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

    return Scaffold(
      body: ListView(
        children: [
          header(),
          passwordCaution(),
          oldPasswordInput(),
          newPasswordInput(),
          confirmationPasswordInput(),
          isLoading
              ? Padding(
                  padding:
                      const EdgeInsets.only(left: 24.0, right: 24, bottom: 30),
                  child: LoadingButton(),
                )
              : saveButton(),
        ],
      ),
    );
  }
}
