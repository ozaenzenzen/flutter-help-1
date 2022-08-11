import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tailorine_mobilev2/models/user_model.dart';
import 'package:tailorine_mobilev2/screens/history_screen.dart';
import 'package:tailorine_mobilev2/screens/home_screen.dart';
import 'package:tailorine_mobilev2/screens/profile_screen.dart';
import 'package:tailorine_mobilev2/shared/theme.dart';

import '../provider/page_provider.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    Widget customBottomNav() {
      return BottomAppBar(
        elevation: 0,
        child: SizedBox(
          height: 52,
          child: BottomNavigationBar(
            selectedFontSize: 0,
            unselectedFontSize: 0,
            enableFeedback: false,
            backgroundColor: bgColor,
            currentIndex: pageProvider.currentIndex,
            onTap: (value) {
              pageProvider.currentIndex = value;
            },
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Container(
                  // padding: EdgeInsets.only(top: ),
                  child: Image.asset(
                    'assets/icons/home.png',
                    width: 20,
                    color: pageProvider.currentIndex == 0
                        ? primaryColor
                        : Color(0xff808191),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  // padding: EdgeInsets.only(top: 5),
                  child: Image.asset(
                    'assets/icons/calendar.png',
                    width: 20,
                    color: pageProvider.currentIndex == 1
                        ? primaryColor
                        : Color(0xff808191),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  // padding: EdgeInsets.only(top: 5),
                  child: Image.asset(
                    'assets/icons/profile.png',
                    width: 20,
                    color: pageProvider.currentIndex == 2
                        ? primaryColor
                        : Color(0xff808191),
                  ),
                ),
                label: '',
              ),
            ],
          ),
        ),
      );
    }

    Widget body() {
      switch (pageProvider.currentIndex) {
        case 0:
          return HomeScreen();
        case 1:
          return HistoryScreen();
        case 2:
          return ProfileScreen();
        default:
          return HomeScreen();
      }
    }

    return Scaffold(
      bottomNavigationBar: customBottomNav(),
      body: body(),
    );
  }
}
