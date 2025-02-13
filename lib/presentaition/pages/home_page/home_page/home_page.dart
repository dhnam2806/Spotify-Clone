import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify/spotify.dart';
import 'package:spotify_clone/core/config/app_color.dart';
import 'package:spotify_clone/core/config/app_constant.dart';
import 'package:spotify_clone/core/config/app_size.dart';
import 'package:spotify_clone/domain/entities/album_info.dart';
import 'package:spotify_clone/domain/usecase/get_album_usecase.dart';
import 'package:spotify_clone/presentaition/bloc/album_bloc/bloc/album_bloc.dart';
import 'package:spotify_clone/presentaition/bloc/authentication_bloc/bloc/authentication_bloc.dart';
import 'package:spotify_clone/presentaition/bloc/home_bloc/bloc/home_bloc.dart';
import 'package:spotify_clone/presentaition/pages/album_page/album_page.dart';
import 'package:spotify_clone/presentaition/pages/components/album_widget.dart';
import 'package:spotify_clone/presentaition/pages/user_page/user_page.dart';
import 'package:spotify_clone/timer/token_manager.dart';
import 'package:http/http.dart' as http;
import '../../../bloc/sign_in_bloc/bloc/sign_in_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final SpotifyApi spotify;
  late List<AlbumInfo> albumInfo = [];
  late List<AlbumInfo> albumForYou = [];
  List<String> albumIds = [
    '4mAcUoAr1QEtTBvtxl0EgK',
    '5V2GmJfj5slTlr1VZ9YCmJ',
    '7tjxEVSNLJpBEHzauIN2NR',
    '5DVFGxUAB9JpyewHIS30GW',
  ];
  List<String> playlistId = ['73TqyloesoAnxOhCKtesp9', '4jtTyXUCoGk0kY4KnleRC5'];

  @override
  void initState() {
    final credentials = SpotifyApiCredentials(
      AppConstant.clientId,
      AppConstant.clientSecret,
      accessToken: token, // Lấy access_token từ TokenManager
    );
    spotify = SpotifyApi(credentials);
    // fetchNewReleases();
    // fetchAlbumsByIds(albumIds);
    // fetchPlaylist(playlistId);
    super.initState();
  }

  Future<void> fetchRecentlyPlayed() async {
    final GetNewRealeaseUseCase getNewRealeaseUseCase = GetNewRealeaseUseCase();
    albumInfo = await getNewRealeaseUseCase.getAlbum();
    print(albumInfo);
  }

  Future<void> fetchNewReleases() async {
    // URL API Spotify
    const url = 'https://api.spotify.com/v1/browse/new-releases';

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final albums = data['albums']['items'];
        for (var album in albums) {
          albumInfo.add(AlbumInfo(
            id: album['id'],
            name: album['name'],
            artist: album['artists'][0]['name'],
            image: album['images'][0]['url'],
          ));
        }
      } else {
        // Xử lý lỗi
        print('Lỗi: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Lỗi kết nối: $e');
    }
  }

  Future<List<AlbumInfo>> fetchAlbumsByIds(List<String> ids) async {
    // URL API Spotify
    const String url = 'https://api.spotify.com/v1/albums'; // Đường dẫn API lấy album theo ID

    // Danh sách lưu trữ AlbumInfo
    List<AlbumInfo> albumInfoList = [];

    try {
      // Tham số truyền vào API: ids cách nhau bởi dấu phẩy (,)
      final idsString = ids.join(',');

      // Gửi yêu cầu HTTP GET với header Authorization
      final response = await http.get(
        Uri.parse('$url?ids=$idsString'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      // Kiểm tra mã trạng thái trả về từ API
      if (response.statusCode == 200) {
        // Giải mã dữ liệu JSON trả về
        final data = jsonDecode(response.body);

        // Xử lý dữ liệu albums
        final albums = data['albums'];
        for (var album in albums) {
          albumForYou.add(AlbumInfo(
            name: album['name'],
            artist: album['artists'][0]['name'],
            image: album['images'][0]['url'],
          ));
        }
      } else {
        // Xử lý lỗi
        print('Lỗi: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Lỗi kết nối: $e');
    }

    // Trả về danh sách album
    return albumInfoList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Chào buổi sáng',
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.white)),
              hPad12,
              hPad12,
              Text(
                'Mới phát hành',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.white),
              ),
              hPad12,
              BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (previous, current) => previous.newRealease != current.newRealease,
                builder: (context, state) {
                  albumInfo = state.newRealease;
                  return Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: albumInfo.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                        create: (context) => AlbumBloc(),
                                        child: AlbumPage(albumInfo: albumInfo[index])))),
                            child: AlbumWidget(
                              albumInfo: albumInfo[index],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              hPad8,
              Text(
                'Dành cho bạn',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: AppColors.white),
              ),
              hPad12,
              BlocBuilder<HomeBloc, HomeState>(
                buildWhen: (previous, current) => previous.albumForYou != current.albumForYou,
                builder: (context, state) {
                  albumForYou = state.albumForYou;
                  return Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: albumForYou.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: GestureDetector(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                        create: (context) => AlbumBloc(),
                                        child: AlbumPage(albumInfo: albumForYou[index])))),
                            child: AlbumWidget(
                              albumInfo: albumForYou[index],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              hPad12,
              // SongWidget(
              //   onTap: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => const SongPlayerPage()));
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
