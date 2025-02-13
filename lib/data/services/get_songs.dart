import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spotify_clone/domain/entities/album_info.dart';
import 'package:spotify_clone/domain/entities/music_info.dart';

import '../../timer/token_manager.dart';

class GetSongsService {
  Future<List<AlbumInfo>> fetchNewReleases() async {
    // URL API Spotify
    const url = 'https://api.spotify.com/v1/browse/new-releases';
    final List<AlbumInfo> albumInfo = [];

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      // Kiểm tra mã trạng thái trả về từ API
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Xử lý dữ liệu
        final albums = data['albums']['items'];
        for (var album in albums) {
          albumInfo.add(AlbumInfo(
            id: album['id'],
            name: album['name'],
            artist: album['artists'][0]['name'],
            image: album['images'][0]['url'],
          ));
        }
        return albumInfo;
      } else {
        // Xử lý lỗi
        print('Lỗi: ${response.statusCode}, ${response.body}');
        return albumInfo;
      }
    } catch (e) {
      print('Lỗi kết nối: $e');
    }
    return albumInfo;
  }

  Future<List<AlbumInfo>> fetchPlaylist(List<String> ids) async {
    // URL cơ bản của API Spotify
    const String baseUrl = 'https://api.spotify.com/v1/playlists';

    // Danh sách lưu trữ AlbumInfo
    List<AlbumInfo> albumForYou = [];

    try {
      for (String id in ids) {
        // Gửi yêu cầu GET với từng ID
        final response = await http.get(
          Uri.parse('$baseUrl/$id'), 
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        );

        // Kiểm tra mã trạng thái phản hồi
        if (response.statusCode == 200) {
          // Giải mã dữ liệu JSON trả về
          final data = jsonDecode(response.body);

          albumForYou.add(
            AlbumInfo(
              name: data['name'],
              artist: data['artists'][0]['name'],
              image: data['images'][0]['url'],
            ),
          );
        } else {
          print('Lỗi với ID: $id - ${response.statusCode}, ${response.body}');
        }
      }
    } catch (e) {
      print('Lỗi kết nối: $e');
    }

    // Trả về danh sách album đã tổng hợp
    return albumForYou;
  }

  Future<List<AlbumInfo>> fetchAlbumsByIds(List<String> ids) async {
    // URL API Spotify
    const String url = 'https://api.spotify.com/v1/albums'; // Đường dẫn API lấy album theo ID

    // Danh sách lưu trữ AlbumInfo
    List<AlbumInfo> albumForYou = [];

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
    return albumForYou;
  }

  Future<List<MusicInfo>> fetchAlbumTracks(String id) async {
    // URL API Spotify
    final url = 'https://api.spotify.com/v1/albums/$id/tracks?market=VN';
    final List<MusicInfo> listMusic = [];

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Giải mã dữ liệu JSON trả về
        final data = jsonDecode(response.body);

        // Xử lý dữ liệu
        final albums = data['items'];
        for (var album in albums) {
          listMusic.add(MusicInfo(
            trackId: album['id'],
            songName: album['name'],
            artistName: album['artists'][0]['name'],
          ));
        }
        return listMusic;
      } else {
        // Xử lý lỗi
        print('Lỗi: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Lỗi kết nối: $e');
    }
    return listMusic;
  }
}
