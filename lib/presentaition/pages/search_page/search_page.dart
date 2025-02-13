import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:spotify_clone/core/config/app_color.dart';
import 'package:spotify_clone/presentaition/pages/song_player_page/song_player_page.dart';
import 'package:spotify_clone/timer/token_manager.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _songs = [];
  bool _isLoading = false;

  Future<void> searchMusic(String query) async {
    if (query.isEmpty) return;

    setState(() => _isLoading = true);

    final dio = Dio();
    final url = "https://api.spotify.com/v1/search?q=$query&type=track&limit=10";

    try {
      final response = await dio.get(
        url,
        options: Options(headers: {"Authorization": "Bearer $token", "Content-Type": "application/json"}),
      );

      setState(() {
        _songs = response.data['tracks']['items'];
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      print("Lỗi khi gọi API: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text("Tìm kiếm nhạc", style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.background,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              controller: _searchController,
              cursorColor: AppColors.green,
              decoration: InputDecoration(
                hintText: "Nhập tên bài hát...",
                hintStyle: const TextStyle(color: Colors.grey),
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: AppColors.green)),
              ),
              onSubmitted: searchMusic,
            ),
          ),
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _songs.isEmpty
                    ? const Center(child: Text("Không tìm thấy kết quả"))
                    : ListView.builder(
                        itemCount: _songs.length,
                        itemBuilder: (context, index) {
                          var song = _songs[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => SongPlayerPage(trackId: song['id'])));
                            },
                            child: ListTile(
                              leading: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    image: DecorationImage(image: NetworkImage(song['album']['images'][0]['url']))),
                              ),
                              title: Text(song['name'], style: const TextStyle(color: Colors.white)),
                              subtitle: Text(song['artists'][0]['name'], style: const TextStyle(color: Colors.grey)),
                              trailing: const Icon(Icons.play_arrow, color: Colors.green),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
