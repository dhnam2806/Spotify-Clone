import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:spotify_clone/core/config/app_color.dart';
import 'package:spotify_clone/core/config/app_size.dart';
import 'package:spotify_clone/presentaition/bloc/authentication_bloc/bloc/authentication_bloc.dart';
import 'package:spotify_clone/presentaition/bloc/sign_up_bloc/bloc/sign_up_bloc.dart';
import 'package:spotify_clone/presentaition/pages/app_view.dart';
import 'package:spotify_clone/presentaition/pages/authen/sign_up/sign_up_page.dart';
import 'package:spotify_clone/presentaition/pages/authen/login/login_page.dart';

import '../../../core/config/app_icons.dart';
import '../../bloc/sign_in_bloc/bloc/sign_in_bloc.dart';
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
              '   Hàng triệu bài hát.\n Miễn phí trên Muzik.',
              style: TextStyle(color: AppColors.white, fontSize: 28, fontWeight: FontWeight.bold),
            ),
            hPad24,
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BlocProvider(
                              create: (context) =>
                                  SignUpBloc(userRepository: context.read<AuthenticationBloc>().userRepository),
                              child: const SignUpPage(),
                            )));
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
                  'Đăng ký',
                  style: TextStyle(color: AppColors.black, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            hPad12,
            BlocProvider(
              create: (context) => SignUpBloc(userRepository: context.read<AuthenticationBloc>().userRepository),
              child: BlocBuilder<SignUpBloc, SignUpState>(
                builder: (context, state) {
                  return ContinueButtonWidget(
                      text: 'Tiếp tục với Google',
                      icon: AppIcons.icGoogle,
                      onPressed: () async {
                        context.read<SignUpBloc>().add(const SignUpWithGoogle());
                        Navigator.push(context, MaterialPageRoute(builder: (_) => const MyAppView()));
                      });
                },
              ),
            ),
            hPad12,
            // continue with facebook
            ContinueButtonWidget(
                text: 'Tiếp tục với Facebook',
                icon: AppIcons.icFacebook,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const MyAppView()));
                }),
            hPad4,
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => BlocProvider(
                              create: (context) =>
                                  SignInBloc(userRepository: context.read<AuthenticationBloc>().userRepository),
                              child: const LoginPage(),
                            )));
              },
              child: Container(
                width: 337.w,
                height: 49.h,
                alignment: Alignment.center,
                child: const Text(
                  'Đăng nhập',
                  style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            hPad32,
          ],
        ),
      ),
    ));
  }

  signInWithGoogle() async {
    try {
      final googleSignInAccount = await GoogleSignIn().signIn();
      if (googleSignInAccount == null) {
        return;
      }
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(authCredential);
    } catch (e) {
      print(e);
    }
  }
}
