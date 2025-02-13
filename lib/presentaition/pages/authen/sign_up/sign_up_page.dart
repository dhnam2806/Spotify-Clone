import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify_clone/core/config/app_color.dart';
import 'package:spotify_clone/core/config/app_constant.dart';
import 'package:spotify_clone/core/config/app_size.dart';
import 'package:spotify_clone/domain/entities/my_user.dart';
import 'package:spotify_clone/presentaition/pages/app_view.dart';
import 'package:spotify_clone/presentaition/pages/authen/components/textfield_widget.dart';

import '../../../bloc/sign_up_bloc/bloc/sign_up_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool obscurePassword = true;
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool signUpRequired = false;

  bool containsUpperCase = false;
  bool contains8Length = false;

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
          child: SingleChildScrollView(
        child: BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            if (state is SignUpSuccess) {
              setState(() {
                signUpRequired = false;
              });
            } else if (state is SignUpProcess) {
              setState(() {
                signUpRequired = true;
              });
            } else if (state is SignUpFailure) {
              return;
            }
            if (state is SignUpSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Đăng ký thành công'),
                  backgroundColor: Colors.green,
                ),
              );
            }
            if (state is SignUpFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
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
                      'Tạo tài khoản',
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
                          prefixIcon: const Icon(CupertinoIcons.mail_solid),
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
                        'Bạn sẽ sử dụng email này để đăng nhập.',
                        style: TextStyle(
                          fontSize: 12.sp,
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
                          prefixIcon: const Icon(CupertinoIcons.lock_fill),
                          onChanged: (val) {
                            if (val!.contains(RegExp(r'[A-Z]'))) {
                              setState(() {
                                containsUpperCase = true;
                              });
                            } else {
                              setState(() {
                                containsUpperCase = false;
                              });
                            }
                            if (val.length >= 8) {
                              setState(() {
                                contains8Length = true;
                              });
                            } else {
                              setState(() {
                                contains8Length = false;
                              });
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
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Vui lòng không để trống trường này';
                            } else if (!passwordRexExp.hasMatch(val)) {
                              return 'Vui lòng nhập mật khẩu hợp lệ';
                            }
                            return null;
                          }),
                      hPad4,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "⚈  Mật khẩu phải chứa ít nhất 1 ký tự viết hoa",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: containsUpperCase ? AppColors.green : AppColors.white,
                            ),
                          ),
                          wPad4,
                          Text(
                            "⚈  Mật khẩu phải chứa ít nhất 8 ký tự",
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: contains8Length ? AppColors.green : AppColors.white,
                            ),
                          ),
                        ],
                      ),
                      hPad12,
                      MyTextFieldWidget(
                          controller: nameController,
                          hintText: 'Tên hiển thị',
                          obscureText: false,
                          keyboardType: TextInputType.name,
                          prefixIcon: const Icon(CupertinoIcons.person_fill),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'Vui lòng không để trống trường này';
                            } else if (val.length > 30) {
                              return 'Tên hiển thị không được quá 30 ký tự';
                            }
                            return null;
                          }),
                    ],
                  ),
                ),
                hPad24,
                Center(
                  child: GestureDetector(
                    onTap: () {
                      if (emailController.text.isEmpty || passController.text.isEmpty || nameController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Vui lòng điền đầy đủ thông tin'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                      if (contains8Length == false || containsUpperCase == false) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Vui lòng nhập mật khẩu hợp lệ'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      }
                      MyUser myUser = MyUser.empty;
                      myUser = myUser.copyWith(
                        email: emailController.text,
                        name: nameController.text,
                      );

                      context.read<SignUpBloc>().add(SignUpRequired(myUser, emailController.text, passController.text));
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MyAppView()));
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
                        'Đăng ký',
                        style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      )),
    );
  }
}
