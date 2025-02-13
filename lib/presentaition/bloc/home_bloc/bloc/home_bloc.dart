import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spotify_clone/data/services/get_songs.dart';
import 'package:spotify_clone/domain/entities/album_info.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeState()) {
    on<HomeInitialEvent>(homeInitialEvent);
  }

  FutureOr<void> homeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(loading: true));
    final albumInfo = await GetSongsService().fetchNewReleases();
    List<String> albumIds = [
      '4mAcUoAr1QEtTBvtxl0EgK',
      '5V2GmJfj5slTlr1VZ9YCmJ',
      '7tjxEVSNLJpBEHzauIN2NR',
      '5DVFGxUAB9JpyewHIS30GW',
    ];
    // List<String> playlistId = ['73TqyloesoAnxOhCKtesp9', '4jtTyXUCoGk0kY4KnleRC5'];
    final albumForYou = await GetSongsService().fetchAlbumsByIds(albumIds);
    emit(state.copyWith(newRealease: albumInfo, albumForYou: albumForYou, loading: false));
  }
}
