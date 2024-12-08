import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify_clone/core/config/app_color.dart';
import 'package:spotify_clone/core/config/app_size.dart';
import 'package:spotify_clone/presentaition/pages/login_page/auth_main.dart';
import 'package:spotify_clone/presentaition/pages/sign_up/components/text_field_widget.dart';

class EmailSignUpPage extends StatefulWidget {
  const EmailSignUpPage({super.key});

  @override
  State<EmailSignUpPage> createState() => _EmailSignUpPageState();
}

class _EmailSignUpPageState extends State<EmailSignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
              ),
              Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 20.w),
            ],
          ),
          hPad12,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What\'s your email?',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                hPad12,
                TextFieldWidget(controller: emailController, hintText: 'Email'),
                hPad4,
                Text(
                  'You\'ll need to confirm this email later.',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: AppColors.white,
                  ),
                ),
                hPad12,
                Text(
                  'Create a password',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                hPad12,
                TextFieldWidget(controller: passController, hintText: 'Password'),
                hPad4,
                Text(
                  'Use atleast 8 characters.',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
          hPad24,
          Center(
            child: GestureDetector(
              onTap: () async {
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: emailController.text,
                  password: passController.text,
                );
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const AuthMain()));
              },
              child: Container(
                width: 84.w,
                height: 36.h,
                decoration: BoxDecoration(
                  color: AppColors.green,
                  borderRadius: BorderRadius.circular(45.r),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'Next',
                  style: TextStyle(color: AppColors.black, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
