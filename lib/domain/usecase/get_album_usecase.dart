import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:spotify_clone/data/services/get_album.dart';
import 'package:spotify_clone/domain/entities/album_info.dart';
import 'package:spotify_clone/timer/token_manager.dart';

class GetNewRealeaseUseCase {
  NewRealeaseService newRealeaseService = NewRealeaseService();

  Future<List<AlbumInfo>> getAlbum() async {
    final response = await newRealeaseService.getAlbums();
    final List<AlbumInfo> albumInfo = response!.albums.items!
        .map((e) => AlbumInfo(
              name: e.name,
              artist: e.artists!.map((e) => e.name).join(', '),
              image: e.images!.first.url,
            ))
        .toList();

    return albumInfo;
  }
}
