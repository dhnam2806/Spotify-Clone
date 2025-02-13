import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify_clone/core/config/app_color.dart';
import 'package:spotify_clone/data/services/favorite_service.dart';
import 'package:spotify_clone/presentaition/pages/song_player_page/song_player_page.dart';

class FavoriteSongsScreen extends StatefulWidget {
  const FavoriteSongsScreen({super.key});

  @override
  _FavoriteSongsScreenState createState() => _FavoriteSongsScreenState();
}

class _FavoriteSongsScreenState extends State<FavoriteSongsScreen> {
  final FavoriteService _favoriteService = FavoriteService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "Bài hát yêu thích",
            style: TextStyle(color: AppColors.white),
          ),
          backgroundColor: AppColors.background),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _favoriteService.getFavoriteSongs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Chưa có bài hát yêu thích nào!"));
          }

          final favoriteSongs = snapshot.data!;

          return ListView.builder(
            itemCount: favoriteSongs.length,
            itemBuilder: (context, index) {
              final song = favoriteSongs[index];

              return ListTile(
                leading: Image.network(song["imageUrl"], width: 50, height: 50, fit: BoxFit.cover),
                title: Text(song["songName"],
                    style: TextStyle(fontSize: 16.sp, color: AppColors.white, fontWeight: FontWeight.bold)),
                subtitle: Text(
                  song["artistName"],
                  style: const TextStyle(color: AppColors.grayText),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _favoriteService.removeFavoriteSong(song["songId"]);
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SongPlayerPage(
                        trackId: song["songId"],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
