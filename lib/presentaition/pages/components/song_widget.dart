import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:spotify_clone/core/config/app_color.dart';
import 'package:spotify_clone/core/config/app_icons.dart';
import 'package:spotify_clone/core/config/app_size.dart';

class SongWidget extends StatelessWidget {
  const SongWidget({super.key, this.songName, this.singer, this.onTap});
  final String? songName;
  final String? singer;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    
    return GestureDetector(
      onTap: () => onTap!(),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              image: const DecorationImage(
                image: AssetImage(AppImages.imgAlbum),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nét', style: TextStyle(color: AppColors.white, fontSize: 14.sp, fontWeight: FontWeight.bold)),
                const Text(
                  'Cường Seven, Phan Đình Tùng, Bằng Kiều, Jun Phạm, Tự Long, Tuấn Hưng',
                  maxLines: 1,
                  style: TextStyle(fontSize: 12, overflow: TextOverflow.ellipsis, color: Colors.grey),
                ),
              ],
            ),
          ),
          wPad8,
          GestureDetector(
              onTap: () {
                showMaterialModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                    height: 400.h,
                    color: AppColors.gray,
                    child: Column(
                      children: [
                        ListTile(
                          leading: const Icon(Icons.play_circle_fill, color: AppColors.white),
                          title: const Text('Play'),
                        ),
                        ListTile(
                          leading: const Icon(Icons.favorite_border, color: AppColors.white),
                          title: const Text('Add to favorite'),
                        ),
                        ListTile(
                          leading: const Icon(Icons.playlist_add, color: AppColors.white),
                          title: const Text('Add to playlist'),
                        ),
                        ListTile(
                          leading: const Icon(Icons.download, color: AppColors.white),
                          title: const Text('Download'),
                        ),
                        ListTile(
                          leading: const Icon(Icons.share, color: AppColors.white),
                          title: const Text('Share'),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: SvgPicture.asset(AppIcons.icMore)),
        ],
      ),
    );
  }
}
