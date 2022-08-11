import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailorine_mobilev2/models/tailor_model.dart';
import 'package:tailorine_mobilev2/models/user_model.dart';
import 'package:tailorine_mobilev2/provider/auth_provider.dart';
import 'package:tailorine_mobilev2/provider/catalogue_provider.dart';
import 'package:tailorine_mobilev2/provider/page_provider.dart';
import 'package:tailorine_mobilev2/provider/tailor_provider.dart';
import 'package:tailorine_mobilev2/screens/appointment_screen.dart';
import 'package:tailorine_mobilev2/screens/forgot_pass_screen.dart';
import 'package:tailorine_mobilev2/screens/history_screen.dart';
import 'package:tailorine_mobilev2/screens/home_screen.dart';
import 'package:tailorine_mobilev2/screens/intro_screen.dart';
import 'package:tailorine_mobilev2/screens/main_screen.dart';
import 'package:tailorine_mobilev2/screens/profile_screen.dart';
import 'package:tailorine_mobilev2/screens/settings/detail_edit_profile.dart';
import 'package:tailorine_mobilev2/screens/sign_in_screen.dart';
import 'package:tailorine_mobilev2/screens/sign_up_screen.dart';
import 'package:tailorine_mobilev2/screens/splash_screen.dart';
import 'package:tailorine_mobilev2/service/store_data_locally.dart';
import 'package:tailorine_mobilev2/shared/theme.dart';

import 'screens/settings/detail_edit_password.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<UserModel> persistData = UserPreference().getUser();
  UserModel? userModel;

  @override
  void initState() {
    persistData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => TailorProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CatalogueProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tailorine',
        routes: {
          '/main': (context) => MainScreen(),
          '/intro': (context) => IntroScreen(),
          '/sign-in': (context) => SignInPage(),
          '/sign-up': (context) => SignUpPage(),
          '/forgot-password': (context) => ForgotPasswordScreen(),
          '/home': (context) => HomeScreen(),
          '/profile': (context) => ProfileScreen(),
          '/history': (context) => HistoryScreen(),
          '/edit_profile': (context) => DetailEditProfile(),
          '/edit_password': (context) => EditPassword(),
          // '/AppointmentScreen': (context) => AppointmentScreen("uuid", TailorModel()),
        },
        home: Scaffold(
          body: FutureBuilder(
            future: persistData,
            builder: (c, s) {
              switch (s.connectionState) {
                case ConnectionState.none:
                  return Scaffold(
                    body: Center(
                      child: Image.asset(
                        'assets/illustration/no_connection.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                case ConnectionState.waiting:
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    ),
                  );
                default:
                  if (s.hasError) {
                    return SignInPage();
                  } else if (s.hasData) {
                    return SplashScreen();
                  } else {
                    return MainScreen();
                  }
              }
            },
          ),
        ),
      ),
    );
  }
}
