import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/config/app_color.dart';
import '../../../core/config/app_size.dart';

class AlbumWidget extends StatelessWidget {
  final String nameAlbum;
  const AlbumWidget({super.key, required this.nameAlbum});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 168.w,
      height: 44.h,
      decoration: BoxDecoration(
        color: AppColors.gray,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        children: [
          const Icon(Icons.heart_broken, size: 44, color: AppColors.white),
          wPad10,
          Expanded(
              child: Text(
                nameAlbum,
                style: TextStyle(color: AppColors.white, fontSize: 13.sp, fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }
}

