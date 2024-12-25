import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:spotify_clone/core/config/app_color.dart';
import 'package:spotify_clone/presentaition/pages/home_page/home_page/home_page.dart';
import 'package:spotify_clone/presentaition/pages/user_page/user_page.dart';

class GNavBar extends StatefulWidget {
  const GNavBar({super.key});

  @override
  State<GNavBar> createState() => _GNavBarState();
}

class _GNavBarState extends State<GNavBar> {
  int _currentIndex = 0;

  static List<Widget> navScreens = <Widget>[
    const HomePage(),
    const UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navScreens.elementAt(_currentIndex),
      bottomNavigationBar: GNav(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        gap: 8,
        backgroundColor: AppColors.background,
        color: Colors.white,
        activeColor: Colors.white,
        // tabBackgroundColor: AppColors.green,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        duration: const Duration(milliseconds: 400),
        debug: true,
        tabBorderRadius: 100,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Trang chủ',
          ),
          GButton(
            icon: Icons.person,
            text: 'Tài khoản',
          ),
        ],
        selectedIndex: _currentIndex,
        onTabChange: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
