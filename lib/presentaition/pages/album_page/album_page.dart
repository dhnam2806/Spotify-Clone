import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:spotify_clone/core/config/app_size.dart';
import 'package:spotify_clone/domain/entities/album_info.dart';
import 'package:http/http.dart' as http;
import 'package:spotify_clone/domain/entities/music_info.dart';
import 'package:spotify_clone/timer/token_manager.dart';

class AlbumPage extends StatefulWidget {
  const AlbumPage({super.key, this.albumInfo});
  final AlbumInfo? albumInfo;

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  late Color albumBg;
  String token = TokenManager().token;
  Future<Color?> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor?.color;
  }

  late List<MusicInfo> listMusic = [];

  void getColor() async {
    final tempSongColor = await getImagePalette(NetworkImage(widget.albumInfo!.image ?? ''));
    setState(() {
      albumBg = tempSongColor!;
    });
  }

  @override
  void initState() {
    super.initState();
    getColor();
    fetchAlbumTracks();
  }

  Future<void> fetchAlbumTracks() async {
    // URL API Spotify
    const url = 'https://api.spotify.com/v1/albums/1wmnEWgcDdCcOujQpLwYxc/tracks?market=VN';

    try {
      // Gửi yêu cầu HTTP GET với header chứa Authorization
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      // Kiểm tra mã trạng thái trả về từ API
      if (response.statusCode == 200) {
        // Giải mã dữ liệu JSON trả về
        final data = jsonDecode(response.body);

        // Xử lý dữ liệu
        final albums = data['items'];
        for (var album in albums) {
          print(album['name'] + ' - ' + album['artists'][0]['name'] + ' - ' + album['id']);
          listMusic.add(MusicInfo(
            trackId: album['id'],
            songName: album['name'],
            artistName: album['artists'][0]['name'],
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: albumBg,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                hPad8,
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 360,
                  child: Container(
                    width: 160.w,
                    height: 160.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      image: DecorationImage(image: NetworkImage(widget.albumInfo!.image ?? '')),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    widget.albumInfo!.name ?? '',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                hPad2,
                Center(
                  child: Text(
                    widget.albumInfo!.artist ?? '',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),

                // List songs
                hPad8,
                Expanded(
                  child: ListView.builder(
                    itemCount: listMusic.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          listMusic[index].songName ?? '',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          listMusic[index].artistName ?? '',
                          style: const TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
