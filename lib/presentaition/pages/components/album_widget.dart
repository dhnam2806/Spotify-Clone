import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify_clone/core/config/app_color.dart';
import 'package:spotify_clone/core/config/app_icons.dart';
import 'package:spotify_clone/core/config/app_size.dart';

class AlbumWidget extends StatefulWidget {
  const AlbumWidget({super.key, this.title, this.subTitle, this.image});
  final String? title;
  final String? subTitle;
  final String? image;

  @override
  State<AlbumWidget> createState() => _AlbumWidgetState();
}

class _AlbumWidgetState extends State<AlbumWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128.w,
      height: 160.h,
      child: Column(
        children: [
          Container(
            width: 128.w,
            height: 128.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              image: const DecorationImage(
                image: AssetImage(AppImages.imgAlbum),
                fit: BoxFit.cover,
              ),
            ),
          ),
          hPad4,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.title == null
                  ? const SizedBox()
                  : Text(
                      widget.title ?? '',
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 13.sp,
                          overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white),
                    ),
              Text(
                widget.subTitle ?? '',
                maxLines: 2,
                style: TextStyle(fontSize: 12.sp, overflow: TextOverflow.ellipsis, color: AppColors.grayText),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
