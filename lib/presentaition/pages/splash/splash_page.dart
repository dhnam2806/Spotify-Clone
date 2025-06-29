import 'package:flutter/material.dart';
import 'package:spotify_clone/presentaition/pages/app.dart';

import '../../../core/config/app_icons.dart';
import '../../../data/repositories/auth_reposiory/firebase_user_repository.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    redirect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(AppImages.imgLogo)),
        ),
      )),
    );
  }

  Future<void> redirect() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => MainApp(FirebaseUserRepository()),
        ));
  }
}
