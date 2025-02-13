import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:spotify/spotify.dart';
import 'package:spotify_clone/core/config/app_color.dart';
import 'package:spotify_clone/core/config/app_constant.dart';
import 'package:spotify_clone/core/config/app_size.dart';
import 'package:spotify_clone/domain/entities/music_info.dart';
import 'package:spotify_clone/presentaition/pages/song_player_page/lyrics_page.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

// ignore: must_be_immutable
class SongPlayerPage extends StatefulWidget {
  SongPlayerPage({super.key, required this.trackId});
  String trackId;

  @override
  State<SongPlayerPage> createState() => _SongPlayerPageState();
}

class _SongPlayerPageState extends State<SongPlayerPage> {
  final player = AudioPlayer();
  late MusicInfo music = MusicInfo(trackId: widget.trackId);
  final spotify = SpotifyApi(SpotifyApiCredentials(AppConstant.clientId, AppConstant.clientSecret));
  @override
  void initState() {
    super.initState();
    spotify.tracks.get(music.trackId).then((track) async {
      String? tempSongName = track.name;
      if (tempSongName != null) {
        music.songName = tempSongName;
        music.artistName = track.artists?.map((a) => a.name).join(', ');
        String? image = track.album?.images?.first.url;
        if (image != null) {
          music.songImage = image;
          final tempSongColor = await getImagePalette(NetworkImage(image));
          if (tempSongColor != null) {
            music.songColor = tempSongColor;
          }
        }
        music.artistImage = track.artists?.first.images?.first.url;
        setState(() {});
        final yt = YoutubeExplode();
        final video = (await yt.search.search("$tempSongName ${music.artistName ?? ""}")).first;
        final videoId = video.id.value;
        music.duration = video.duration;
        setState(() {});
        var manifest = await yt.videos.streamsClient.getManifest(videoId);
        var audioUrl = manifest.audioOnly.last.url;
        player.play(UrlSource(audioUrl.toString()));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Future<Color?> getImagePalette(ImageProvider imageProvider) async {
    final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(imageProvider);
    return paletteGenerator.dominantColor?.color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: music.songColor ?? AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: AppColors.white),
        ),
        backgroundColor: music.songColor ?? AppColors.background,
        title: const Text('Đang phát', style: TextStyle(color: AppColors.white)),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(music.songImage ?? ""),
                ),
              ),
            ),
          ),
          Expanded(flex: 1, child: _playerSong(context)),
        ],
      ),
    );
  }

  Widget _playerSong(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          music.songName ?? "",
                          maxLines: 1,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: AppColors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        hPad4,
                        Text(
                          music.artistName ?? "",
                          maxLines: 1,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Colors.grey,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                wPad12,
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border, color: AppColors.white),
                ),
              ],
            ),
            hPad12,
            const SizedBox(height: 16),
            StreamBuilder(
                stream: player.onPositionChanged,
                builder: (context, data) {
                  return ProgressBar(
                    progress: data.data ?? const Duration(seconds: 0),
                    total: music.duration ?? const Duration(minutes: 4),
                    bufferedBarColor: Colors.white38,
                    baseBarColor: Colors.white10,
                    thumbColor: Colors.white,
                    timeLabelTextStyle: const TextStyle(color: Colors.white),
                    progressBarColor: Colors.white,
                    onSeek: (duration) {
                      player.seek(duration);
                    },
                  );
                }),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LyricsPage(
                                    music: music,
                                    player: player,
                                  )));
                    },
                    icon: const Icon(Icons.lyrics_outlined, color: Colors.white)),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.skip_previous,
                      color: Colors.white,
                      size: 36,
                    )),
                IconButton(
                    onPressed: () async {
                      if (player.state == PlayerState.playing) {
                        await player.pause();
                      } else {
                        await player.resume();
                      }
                      setState(() {});
                    },
                    icon: Icon(
                      player.state == PlayerState.playing ? Icons.pause : Icons.play_circle,
                      color: Colors.white,
                      size: 60,
                    )),
                IconButton(onPressed: () {}, icon: const Icon(Icons.skip_next, color: Colors.white, size: 36)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.loop, color: AppColors.white, size: 24)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
