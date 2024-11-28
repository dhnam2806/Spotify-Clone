import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify_clone/core/config/app_color.dart';
import 'package:spotify_clone/core/config/app_size.dart';

class PassSignUpPage extends StatefulWidget {
  const PassSignUpPage({super.key});

  @override
  State<PassSignUpPage> createState() => _PassSignUpPageState();
}

class _PassSignUpPageState extends State<PassSignUpPage> {
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
                  'Create a password',
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                hPad12,
                TextField(
                  controller: passController,
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 16.sp,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(
                      color: AppColors.gray,
                      fontSize: 16.sp,
                    ),
                    filled: true,
                    fillColor: AppColors.grayTextField,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
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
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const PassSignUpPage()));
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
