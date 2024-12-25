import 'dart:ffi';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:spotify_clone/core/config/app_color.dart';
import 'package:spotify_clone/core/config/app_icons.dart';
import 'package:spotify_clone/core/config/app_size.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Uint8List? _image;
  @override
  Widget build(BuildContext context) {
    onProfilePicker() async {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        return await image.readAsBytes();
      }
      print('No image selected.');
    }

    void selectImage() async {
      Uint8List? image = await onProfilePicker();
      setState(() {
        _image = image;
      });
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        automaticallyImplyLeading: false,
        title: const Text('Tài khoản',
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            )),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          hPad8,
          Center(
            child: Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 80.r,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : CircleAvatar(
                        radius: 80.r,
                        backgroundImage: const NetworkImage(
                            'https://hobiverse.com.vn/cdn/shop/articles/gojo-hoi-sinh_thumbnail_hobi_7731cec1b1dd4ffba620530167bcde4d.jpg?v=1716179288 '),
                      ),
                Positioned(
                  bottom: 0,
                  right: 8.w,
                  child: GestureDetector(
                    onTap: () => selectImage(),
                    child: Container(
                      width: 30.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: AppColors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          hPad8,
          Text(
            'Dương Nam',
            style: TextStyle(
              fontSize: 24.sp,
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          hPad4,
          Text(
            'duonghainam286@gmail.com',
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.grayText,
            ),
          ),
          hPad12,
          //like song
          Row(
            children: [
              Container(
                width: 60.w,
                height: 60.h,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(left: 16),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.imgLiked),
                  ),
                ),
              ),
              wPad12,
              Text(
                'Bài hát yêu thích',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          hPad20,
          GestureDetector(
            onTap: () async {
              await FirebaseAuth.instance.signOut();
            },
            child: Container(
              width: 120.w,
              height: 49.h,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.green,
                borderRadius: BorderRadius.circular(45.r),
              ),
              alignment: Alignment.center,
              child: Text(
                'Đăng xuất',
                style: TextStyle(color: AppColors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
