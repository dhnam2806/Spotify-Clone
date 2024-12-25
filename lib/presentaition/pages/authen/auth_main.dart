import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spotify_clone/presentaition/pages/bottom_nav_bar_widget.dart';
import 'package:spotify_clone/presentaition/pages/authen/get_started_page.dart';

class AuthMain extends StatelessWidget {
  const AuthMain({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const GNavBar();
          }
          return const GetStartedPage();
        });
  }
}
