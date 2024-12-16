import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify/spotify.dart';
import 'package:spotify_clone/core/config/app_color.dart';
import 'package:spotify_clone/core/config/app_constant.dart';
import 'package:spotify_clone/core/config/app_icons.dart';
import 'package:spotify_clone/core/config/app_size.dart';
import 'package:spotify_clone/presentaition/pages/components/album_widget.dart';
import 'package:spotify_clone/timer/token_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final SpotifyApi spotify;

  @override
  void initState() {
    final credentials = SpotifyApiCredentials(
      AppConstant.clientId,
      AppConstant.clientSecret,
      accessToken: TokenManager().token, // Lấy access_token từ TokenManager
    );
    spotify = SpotifyApi(credentials);
    print(credentials.accessToken);
    spotify.tracks.get('44sYmL97Lv8mEbzgANFkPD').then((track) {
      print('Name: ${track.name}');
      print('Album: ${track.album?.name}');
      print('Artist: ${track.artists?.map((a) => a.name).join(', ')}');
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    Future<void> fetchData() async {
      try {
        final data = spotify.browse.newReleases(country: Market.VN);
        data.getPage(10);
        print(data.getPage(10));
      } catch (e) {
        print(e);
      }
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 24.w,
                    height: 24.h,
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.person, size: 24, color: AppColors.black),
                  ),
                  wPad10,
                  Text('Good evening',
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.white)),
                ],
              ),
              hPad12,
              const Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  AlbumWidget(nameAlbum: 'Liked Songs'),
                  AlbumWidget(nameAlbum: 'Chúng ta không thuộc về nhau'),
                  AlbumWidget(nameAlbum: 'Có chàng trai viết lên cây'),
                  AlbumWidget(nameAlbum: 'Đừng làm trái tim anh đau'),
                ],
              ),
              hPad12,
              Text('Recently played',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColors.white)),
              // GestureDetector(
              //     onTap: () async {
              //       Timer(const Duration(seconds: 3), () {
              //         final tokenManager = TokenManager();
              //         tokenManager.stopFetchingToken();
              //       });
              //       await FirebaseAuth.instance.signOut();
              //     },
              //     child: const Text('Home Page')),
              // hPad8,
              // GestureDetector(
              //     onTap: () {
              //       fetchData();
              //     },
              //     child: const Text('Welcome to Spotify Clone')),
            ],
          ),
        ),
      ),
    );
  }
}
