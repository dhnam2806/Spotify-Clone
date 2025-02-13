import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spotify_clone/data/services/get_songs.dart';
import 'package:spotify_clone/domain/entities/music_info.dart';

part 'album_event.dart';
part 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  AlbumBloc() : super(const AlbumState()) {
    on<AlbumInitialEvent>(albumInitialEvent);
  }

  FutureOr<void> albumInitialEvent(AlbumInitialEvent event, Emitter<AlbumState> emit) async {
    emit(state.copyWith(loading: true));
    final listMusic = await GetSongsService().fetchAlbumTracks(event.id);
    emit(state.copyWith(listMusic: listMusic, loading: false));
  }
}
