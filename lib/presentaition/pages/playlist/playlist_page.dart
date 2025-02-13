import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spotify_clone/core/config/app_color.dart';
import 'package:spotify_clone/data/services/playlist_service.dart';
import 'package:spotify_clone/presentaition/pages/song_player_page/song_player_page.dart';

class PlaylistDetailScreen extends StatelessWidget {
  final String playlistId;
  final String playlistName;
  final PlaylistService _playlistService = PlaylistService();

  PlaylistDetailScreen({super.key, required this.playlistId, required this.playlistName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
          backgroundColor: AppColors.background,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(playlistName, style: const TextStyle(color: AppColors.white))),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _playlistService.getSongsInPlaylist(playlistId),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Chưa có bài hát nào!"));
          }

          final songs = snapshot.data!;

          return ListView.builder(
            itemCount: songs.length,
            itemBuilder: (context, index) {
              final song = songs[index];

              return ListTile(
                leading: Image.network(song["imageUrl"], width: 60, height: 60, fit: BoxFit.cover),
                title: Text(song["songName"],
                    style: TextStyle(fontSize: 16.sp, color: AppColors.white, fontWeight: FontWeight.w500)),
                subtitle: Text(song["artistName"], style: const TextStyle(color: AppColors.grayText)),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _playlistService.removeSongFromPlaylist(playlistId, song["songId"]);
                  },
                ),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => SongPlayerPage(trackId: song["songId"])));
                },
              );
            },
          );
        },
      ),
    );
  }
}
