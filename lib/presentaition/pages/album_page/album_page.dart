import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:spotify_clone/core/config/app_color.dart';
import 'package:spotify_clone/core/config/app_size.dart';
import 'package:spotify_clone/domain/entities/album_info.dart';
import 'package:spotify_clone/domain/entities/music_info.dart';
import 'package:spotify_clone/presentaition/bloc/album_bloc/bloc/album_bloc.dart';
import 'package:spotify_clone/presentaition/pages/song_player_page/song_player_page.dart';

class AlbumPage extends StatefulWidget {
  const AlbumPage({super.key, this.albumInfo});
  final AlbumInfo? albumInfo;

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  late Color albumBg;
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
    context.read<AlbumBloc>().add(AlbumInitialEvent(widget.albumInfo!.id ?? ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black54,
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.46, 0.56],
                colors: [
                  albumBg,
                  AppColors.background,
                ],
              ),
            ),
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
                  BlocBuilder<AlbumBloc, AlbumState>(
                    builder: (context, state) {
                      final listMusic = state.listMusic;
                      return Expanded(
                        child: ListView.builder(
                          itemCount: listMusic.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => SongPlayerPage(
                                                    trackId: listMusic[index].trackId,
                                                  )));
                                    },
                                    child: ListTile(
                                      title: Text(
                                        listMusic[index].songName ?? '',
                                        style: TextStyle(
                                            fontSize: 16.sp, color: Colors.white, fontWeight: FontWeight.w500),
                                      ),
                                      subtitle: Text(
                                        listMusic[index].artistName ?? '',
                                        style: const TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert, color: Colors.white)),
                              ],
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
