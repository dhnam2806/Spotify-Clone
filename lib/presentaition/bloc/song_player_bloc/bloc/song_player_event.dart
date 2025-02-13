part of 'song_player_bloc.dart';

sealed class SongPlayerEvent extends Equatable {
  const SongPlayerEvent();

  @override
  List<Object> get props => [];
}

final class LoadSongEvent extends SongPlayerEvent {
  final List<String> songIds;

  const LoadSongEvent(this.songIds);
}

final class PlaySongEvent extends SongPlayerEvent {}

final class PauseSongEvent extends SongPlayerEvent {}

final class PreviousSongEvent extends SongPlayerEvent {}

final class NextSongEvent extends SongPlayerEvent {}

class SeekTo extends SongPlayerEvent {
  final Duration position;

  const SeekTo(this.position);
}

