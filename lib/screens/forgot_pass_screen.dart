import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailorine_mobilev2/provider/auth_provider.dart';
import '../shared/theme.dart';
import '../widget/loading_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController(text: '');
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    handleForgotPass() async {
      setState(() {
        isLoading = true;
      });

      if (await authProvider.forgotPassword(
        email: emailController.text,
      )) {
        Navigator.pushNamed(context, '/sign-in');
      } else if (emailController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: errorColor,
            content: Text(
              'Email harus diisi',
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
            Text('Lupa Password anda?', style: titleTextStyle),
            SizedBox(
              height: 2,
            ),
            Row(
              children: [
                Text(
                  'Masukkan email anda yang terhubung\nke Tailorine',
                  style: regularTextStyle,
                ),
              ],
            )
          ],
        ),
      );
    }

    Widget emailInput() {
      return Container(
        margin: EdgeInsets.only(top: 70),
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
              height: 12,
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
                    // Image.asset(
                    //   'assets/icon_email.png',
                    //   width: 17,
                    // ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email tidak boleh kosong';
                          }
                          return null;
                        },
                        style: regularTextStyle,
                        controller: emailController,
                        decoration: InputDecoration.collapsed(
                          hintText: 'Masukkan email anda',
                          hintStyle: regularTextStyle.copyWith(
                              fontSize: 16, color: Colors.grey),
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

    Widget signInButton() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: 30),
        child: TextButton(
          onPressed: () async {
            await handleForgotPass();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: Duration(seconds: 5),
                backgroundColor: successColor,
                content: Text(
                  'Email untuk mereset password telah dikirimkan, silakan periksa email anda',
                  style: regularTextStyle.copyWith(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
          style: TextButton.styleFrom(
            backgroundColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            'Kirim email',
            style: regularTextStyle.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: bgColor,
            ),
          ),
        ),
      );
    }

    // Widget footer() {
    //   return Container(
    //     margin: EdgeInsets.only(top: 12, bottom: 30),
    //     child: GestureDetector(
    //       onTap: () {},
    //       child: Center(
    //           child: GestureDetector(
    //         onTap: () {
    //           Navigator.pushNamed(context, '/sign-up');
    //         },
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Text(
    //               'Belum punya akun?',
    //               style: regularTextStyle.copyWith(color: secondaryColor),
    //             ),
    //             Text(
    //               ' Daftar sekarang!',
    //               style: regularTextStyle.copyWith(
    //                   fontWeight: FontWeight.w400, color: secondaryColor),
    //             ),
    //           ],
    //         ),
    //       )),
    //     ),
    //   );
    // }

    // Widget footer1() {
    //   return Container(
    //     margin: EdgeInsets.only(top: 12),
    //     child: GestureDetector(
    //       onTap: () {},
    //       child: Center(
    //         child: Text(
    //           'Lupa password?',
    //           style: regularTextStyle.copyWith(
    //             fontSize: 12,
    //             fontWeight: FontWeight.w600,
    //             color: secondaryColor,
    //           ),
    //         ),
    //       ),
    //     ),
    //   );
    // }

    return Scaffold(
      backgroundColor: bgColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 32,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(),
              emailInput(),
              isLoading ? LoadingButton() : signInButton(),
              // footer1(),
              // Spacer(),
              // footer(),
            ],
          ),
        ),
      ),
    );
  }
}
