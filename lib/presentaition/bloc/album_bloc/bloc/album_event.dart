part of 'album_bloc.dart';

sealed class AlbumEvent extends Equatable {
  const AlbumEvent();

  @override
  List<Object> get props => [];
}

final class AlbumInitialEvent extends AlbumEvent {
  final String id;

  const AlbumInitialEvent(this.id);
}
