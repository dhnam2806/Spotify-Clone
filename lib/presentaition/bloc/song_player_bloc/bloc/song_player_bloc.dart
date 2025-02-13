import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:spotify/spotify.dart';
import 'package:spotify_clone/core/config/app_constant.dart';
import 'package:spotify_clone/domain/entities/music_info.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

part 'song_player_event.dart';
part 'song_player_state.dart';

class SongPlayerBloc extends Bloc<SongPlayerEvent, SongPlayerState> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<String> _listSong = []; // Danh sách bài hát
  int _currentTrackIndex = 0;
  Uri? _currentTrackUrl; // Chỉ số bài hát hiện tại
  final spotify = SpotifyApi(SpotifyApiCredentials(AppConstant.clientId, AppConstant.clientSecret));

  SongPlayerBloc() : super(SongPlayerInitial()) {
    on<LoadSongEvent>(_loadSongEvent);
    on<PlaySongEvent>(_playSongEvent);
    on<PauseSongEvent>(_pauseSongEvent);
    on<PreviousSongEvent>(_previousSongEvent);
    on<SeekTo>(_seekToEvent);
    on<NextSongEvent>(_nextSongEvent);

    // Lắng nghe khi bài hát phát xong
    _audioPlayer.onPlayerComplete.listen((_) {
      add(NextSongEvent());
    });

    // Lắng nghe tiến trình phát nhạc
    _audioPlayer.onPositionChanged.listen((position) {
      if (state is SongPlayerPlaying) {
        final playingState = state as SongPlayerPlaying;
        emit(SongPlayerPlaying(
          currentTrack: playingState.currentTrack,
          position: position,
          duration: playingState.duration,
        ));
      }
    });

    // Lắng nghe tổng thời gian bài hát
    _audioPlayer.onDurationChanged.listen((duration) {
      if (state is SongPlayerPlaying) {
        final playingState = state as SongPlayerPlaying;
        emit(SongPlayerPlaying(
          currentTrack: playingState.currentTrack,
          position: playingState.position,
          duration: duration,
        ));
      }
    });
  }

  FutureOr<void> _loadSongEvent(LoadSongEvent event, Emitter<SongPlayerState> emit) async {
    MusicInfo music = MusicInfo(trackId: '4N5J0XZhaNro1JFUbzc6oH');
    spotify.tracks.get(music.trackId).then((track) async {
      String? tempSongName = track.name;
      if (tempSongName != null) {
        music.songName = tempSongName;
        music.artistName = track.artists?.map((a) => a.name).join(', ');
        final yt = YoutubeExplode();
        final video = (await yt.search.search("$tempSongName ${music.artistName ?? ""}")).first;
        final videoId = video.id.value;
        music.duration = video.duration;
        var manifest = await yt.videos.streamsClient.getManifest(videoId);
        var audioUrl = manifest.audioOnly.last.url;
        _currentTrackUrl = audioUrl;
        await _audioPlayer.setSourceUrl(UrlSource(audioUrl.toString()).url);
        emit(SongPlayerPlaying(
          currentTrack: music.songName ?? "",
          position: Duration.zero,
          duration: music.duration ?? Duration.zero,
        ));
      }
    });
  }

  FutureOr<void> _playSongEvent(PlaySongEvent event, Emitter<SongPlayerState> emit) async {
    await _audioPlayer.resume();
    emit(SongPlayerPlaying(
      currentTrack: _listSong[_currentTrackIndex],
      position: Duration.zero,
      duration: await _audioPlayer.getDuration() ?? Duration.zero,
    ));
  }

  FutureOr<void> _pauseSongEvent(PauseSongEvent event, Emitter<SongPlayerState> emit) async {
    await _audioPlayer.pause();
    emit(SongPlayerPaused(
      currentTrack: _listSong[_currentTrackIndex],
      position: await _audioPlayer.getCurrentPosition() ?? Duration.zero,
    ));
  }

  FutureOr<void> _seekToEvent(SeekTo event, Emitter<SongPlayerState> emit) async {
    await _audioPlayer.seek(event.position);
  }

  FutureOr<void> _previousSongEvent(PreviousSongEvent event, Emitter<SongPlayerState> emit) async {
    if (_currentTrackIndex > 0) {
      _currentTrackIndex--;
      _audioPlayer.setSourceUrl(_listSong[_currentTrackIndex]);
      add(PlaySongEvent());
    }
  }

  FutureOr<void> _nextSongEvent(NextSongEvent event, Emitter<SongPlayerState> emit) async {
    if (_currentTrackIndex < _listSong.length - 1) {
      _currentTrackIndex++;
      _audioPlayer.setSourceUrl(_listSong[_currentTrackIndex]);
      add(PlaySongEvent());
    }
  }

  @override
  Future<void> close() {
    _audioPlayer.dispose();
    return super.close();
  }
}
