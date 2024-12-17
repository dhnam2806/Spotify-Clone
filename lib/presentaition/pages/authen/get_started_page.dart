import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_clone/core/config/app_color.dart';
import 'package:spotify_clone/core/config/app_size.dart';
import 'package:spotify_clone/presentaition/pages/authen/sign_up/sign_up_page.dart';
import 'package:spotify_clone/presentaition/pages/home_page/home_page/home_page.dart';
import 'package:spotify_clone/presentaition/pages/authen/login/login_page.dart';

import '../../../core/config/app_icons.dart';
import 'components/continue_button_widget.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: double.infinity,
        color: AppColors.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(AppIcons.icLogo),
            hPad24,
            const Text(
              'Millions of Songs.\n  Free on Spotify.',
              style: TextStyle(color: AppColors.white, fontSize: 28, fontWeight: FontWeight.bold),
            ),
            hPad24,
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUpPage()));
              },
              child: Container(
                width: 337.w,
                height: 49.h,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.green,
                  borderRadius: BorderRadius.circular(45.r),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Sign up free',
                  style: TextStyle(color: AppColors.black, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            hPad12,
            ContinueButtonWidget(
              text: 'Continue with Facebook',
              icon: AppIcons.icFacebook,
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
              },
            ),
            hPad12,
            ContinueButtonWidget(
              text: 'Continue with Google',
              icon: AppIcons.icGoogle,
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage())),
            ),
            hPad4,
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage()));
              },
              child: Container(
                width: 337.w,
                height: 49.h,
                alignment: Alignment.center,
                child: const Text(
                  'Login',
                  style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            hPad24,
          ],
        ),
      ),
    ));
  }
}
