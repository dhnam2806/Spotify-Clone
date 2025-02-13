import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YouTubeService {
  final YoutubeExplode _yt = YoutubeExplode();

  // 🔍 Tìm kiếm video trên YouTube từ tên bài hát + nghệ sĩ
  Future<String?> searchYouTube(String songName, String artistName) async {
    try {
      var searchResults = await _yt.search.getVideos("$songName $artistName");
      return searchResults.isNotEmpty ? searchResults.first.id.value : null;
    } catch (e) {
      print("Lỗi tìm kiếm video YouTube: $e");
      return null;
    }
  }

  // 🎵 Lấy link nhạc từ YouTube
  Future<String?> getAudioUrl(String videoId) async {
    try {
      var manifest = await _yt.videos.streamsClient.getManifest(videoId);
      var audioStream = manifest.audioOnly.withHighestBitrate();
      return audioStream.url.toString();
    } catch (e) {
      print("Lỗi lấy URL nhạc từ YouTube: $e");
      return null;
    }
  }

  void dispose() {
    _yt.close();
  }
}
