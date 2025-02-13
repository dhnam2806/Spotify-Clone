part of 'song_player_bloc.dart';

sealed class SongPlayerState extends Equatable {
  const SongPlayerState();

  @override
  List<Object> get props => [];
}

final class SongPlayerInitial extends SongPlayerState {}

final class SongPlayerLoading extends SongPlayerState {}

final class SongPlayerPlaying extends SongPlayerState {
  final String currentTrack; // Bài hát hiện tại
  final Duration position; // Vị trí phát hiện tại
  final Duration duration; // Thời lượng bài hát

  const SongPlayerPlaying({required this.currentTrack, required this.position, required this.duration});

  @override
  List<Object> get props => [currentTrack, position, duration];
}

final class SongPlayerPaused extends SongPlayerState {
  final String currentTrack;
  final Duration position;

  const SongPlayerPaused({required this.currentTrack, required this.position});

  @override
  List<Object> get props => [currentTrack, position];
}

final class SongFinished extends SongPlayerState {}
