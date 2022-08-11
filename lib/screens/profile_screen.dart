import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tailorine_mobilev2/models/tailor_model.dart';
import 'package:tailorine_mobilev2/models/user_model.dart';
import 'package:tailorine_mobilev2/provider/auth_provider.dart';
import 'package:tailorine_mobilev2/screens/appointment_screen.dart';
import 'package:tailorine_mobilev2/service/auth_service.dart';

import '../shared/theme.dart';
import '../widget/settings_widget.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    AuthService().getProfile();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserModel user = authProvider.user;

    void logout() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('token');
      prefs.remove('email');
      Provider.of<AuthProvider>(context, listen: false).logout();
    }

    Widget header() {
      return Padding(
        padding: const EdgeInsets.only(
          right: 24,
          left: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20.0,
              ),
              child: Center(
                child: Text(
                  'Profil Kamu',
                  style: titleTextStyle.copyWith(fontSize: 20, fontWeight: semibold),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget body() {
      return Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          children: [
            // FutureBuilder<UserModel>(
            //   future: AuthService().getProfile(),
            //   builder: (ctx, AsyncSnapshot snap) {
            //     if (snap.hasData) {
            //       return ClipOval(
            //         child: Image.network(
            //           snap.data.profile_picture,
            //           width: 100,
            //           height: 100,
            //           fit: BoxFit.cover,
            //           errorBuilder: (ctx, error, stackTrace) {
            //             return Image.asset(
            //               'assets/logo/logo_app.png',
            //               width: 50,
            //               height: 50,
            //               fit: BoxFit.cover,
            //             );
            //           },
            //         ),
            //       );
            //     } else if (snap.hasError) {
            //       return ClipOval(
            //         child: Image.asset(
            //           'assets/logo/logo_app.png',
            //           width: 100,
            //           height: 100,
            //           fit: BoxFit.cover,
            //         ),
            //       );
            //     }
            //     return Center(
            //       child: SizedBox(),
            //     );
            //   },
            // ),

            //update image

            const SizedBox(height: 10),
            Text(
              // user.first_name! + ' ' + user.last_name!,
              "",
              style: regularTextStyle.copyWith(fontWeight: semibold, fontSize: 20),
            ),
            const SizedBox(height: 4),
            Text(
              // user.address != null ? user.address! : '',
              "",
              style: regularTextStyle.copyWith(fontSize: 16),
            ),
            SizedBox(
              height: 40,
            ),
            InkWell(
              onTap: () {
                // Navigator.pushNamed(context, '/edit_profile');
                Navigator.pushNamed(context, '/AppointmentScreen');
              },
              child: Settings(
                title: 'Edit Profil',
                subtitle: 'Edit profil kamu',
                icons: Icon(Icons.person),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/edit_password');
              },
              child: Settings(
                title: 'Ubah Password',
                subtitle: 'Ubah password kamu',
                icons: Icon(Icons.lock),
              ),
            ),
            Settings(
              title: 'Janji temu kamu',
              subtitle: 'Lihat daftar janji temu kamu1',
              icons: Icon(Icons.calendar_today),
              onTap: () {
                debugPrint("TEST");
                // Navigator.pushNamed(context, '/edit_profile');
                Navigator.pushNamed(context, '/AppointmentScreen');
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return AppointmentScreen(
                //         "uuid",
                //         TailorModel(),
                //       );
                //     },
                //   ),
                // );
              },
            ),
            Settings(
              title: 'Tema',
              subtitle: 'Pilih tema untuk aplikasi',
              icons: Icon(Icons.dark_mode),
              onTap: () {
                // Navigator.pushNamed(context, '/edit_profile');
              },
            ),
            InkWell(
              onTap: () {
                logout();
                Navigator.pushNamed(context, '/sign-in');
              },
              child: Settings(
                title: 'Keluar Akun',
                subtitle: 'Setelah keluar kamu tidak akan bisa\nmembuat janji temu sampai kamu\nmasuk kembali',
                icons: Icon(Icons.exit_to_app_rounded),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: ListView(
          children: [
            header(),
            body(),
          ],
        ),
      ),
    );
  }
}
