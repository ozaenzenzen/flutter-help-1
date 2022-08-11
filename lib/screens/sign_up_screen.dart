import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import '../shared/theme.dart';
import '../widget/loading_button.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();

  bool isLoading = false;
  bool isHide = true;
  void _obscurePass() {
    setState(() {
      isHide = !isHide;
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleSignUp() async {
      setState(() {
        isLoading = true;
      });
      if (await authProvider.register(
        first_name: firstnameController.text,
        last_name: lastnameController.text,
        email: emailController.text,
        password: passwordController.text,
      )) {
        Navigator.pushNamed(context, '/main');
      } else if (emailController.text.isEmpty ||
          passwordController.text.isEmpty ||
          firstnameController.text.isEmpty ||
          lastnameController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: errorColor,
            content: Text(
              'Nama, Email, dan Password harus diisi!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: errorColor,
            content: Text(
              'email sudah terdaftar!',
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
      return Container(
        margin: EdgeInsets.only(top: 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Selamat datang!', style: titleTextStyle),
            SizedBox(
              height: 2,
            ),
            Text(
              'Buat akunmu disini',
              style: regularTextStyle,
            ),
          ],
        ),
      );
    }

    Widget nameInput() {
      return Container(
        margin: EdgeInsets.only(top: 64),
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
                          hintText: 'Masukkan nama depan anda',
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
        margin: EdgeInsets.only(top: 20),
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
                          hintText: 'Masukkan nama belakang anda',
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

    Widget emailInput() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Alamat email',
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
                      Icons.email,
                      size: 17,
                    ),
                    SizedBox(
                      width: 14,
                    ),
                    Expanded(
                      child: TextFormField(
                        style: regularTextStyle,
                        controller: emailController,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Masukkan email anda',
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

    Widget passwordInput() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Password',
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
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: 'Masukkan password anda',
                          hintStyle: regularTextStyle.copyWith(
                            fontSize: 16,
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

    Widget passwordCaution() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            '*Password harus terdiri dari kombinasi huruf dan angka',
            style: regularTextStyle.copyWith(
              color: errorColor,
              fontSize: 10,
            ),
          )
        ],
      );
    }

    Widget signUpButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: 30),
        child: TextButton(
          onPressed: () async {
            handleSignUp();
          },
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Daftar Sekarang',
            style: regularTextStyle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: bgColor,
            ),
          ),
        ),
      );
    }

    Widget footer() {
      return Container(
        margin: EdgeInsets.only(bottom: 30, top: 12),
        child: GestureDetector(
          child: Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/sign-in');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sudah punya akun?',
                    style: regularTextStyle.copyWith(color: secondaryColor),
                  ),
                  Text(
                    ' masuk disini!',
                    style: regularTextStyle.copyWith(
                        fontWeight: FontWeight.w400, color: secondaryColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 32,
          ),
          child: ListView(
            children: [
              header(),
              nameInput(),
              lastnameInput(),
              emailInput(),
              passwordInput(),
              passwordCaution(),
              isLoading ? LoadingButton() : signUpButton(),
              footer(),
            ],
          ),
        ),
      ),
    );
  }

  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
