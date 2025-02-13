import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify_clone/core/config/app_color.dart';
import 'package:spotify_clone/core/config/app_size.dart';
import 'package:spotify_clone/presentaition/bloc/sign_in_bloc/bloc/sign_in_bloc.dart';
import 'package:spotify_clone/presentaition/pages/app_view.dart';
import 'package:spotify_clone/presentaition/pages/authen/components/textfield_widget.dart';

import '../../../../core/config/app_constant.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool signInRequired = false;
  String? _errorMsg;
  bool obscurePassword = true;
  IconData iconPassword = CupertinoIcons.eye_fill;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
          child: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            setState(() {
              signInRequired = false;
            });
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MyAppView()));
          } else if (state is SignInProcess) {
            setState(() {
              signInRequired = true;
            });
          } else if (state is SignInFailure) {
            setState(() {
              signInRequired = false;
              _errorMsg = 'Email hoặc mật khẩu không đúng';
            });
          }
        },
        builder: (context, state) {
          return Column(
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
                    'Đăng nhập tài khoản',
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
                      'Nhập email của bạn',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    hPad12,
                    MyTextFieldWidget(
                        controller: emailController,
                        hintText: 'Email',
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        errorMsg: _errorMsg,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please fill in this field';
                          } else if (!emailRexExp.hasMatch(val)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        }),
                    hPad4,
                    Text(
                      'Nhập email bạn đã đăng ký trước đó.',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: AppColors.white,
                      ),
                    ),
                    hPad12,
                    Text(
                      'Nhập mật khẩu',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    hPad12,
                    MyTextFieldWidget(
                      controller: passController,
                      hintText: 'Mật khẩu',
                      obscureText: obscurePassword,
                      keyboardType: TextInputType.visiblePassword,
                      errorMsg: _errorMsg,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return 'Vui lòng không để trống trường này';
                        }
                        return null;
                      },
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                            if (obscurePassword) {
                              iconPassword = CupertinoIcons.eye_fill;
                            } else {
                              iconPassword = CupertinoIcons.eye_slash_fill;
                            }
                          });
                        },
                        icon: Icon(iconPassword),
                      ),
                    ),
                    hPad4,
                    Text(
                      'Hãy nhập mật khẩu bạn của bạn',
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
                    if (emailController.text.isEmpty || passController.text.isEmpty) {
                      setState(() {
                        _errorMsg = 'Vui lòng điền đầy đủ thông tin';
                      });
                      return;
                    }

                    context.read<SignInBloc>().add(SignInRequired(emailController.text, passController.text));
                  },
                  child: Container(
                    width: 120.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: AppColors.green,
                      borderRadius: BorderRadius.circular(45.r),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Đăng nhập',
                      style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      )),
    );
  }
}
