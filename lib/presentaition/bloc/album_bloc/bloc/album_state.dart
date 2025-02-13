part of 'album_bloc.dart';

final class AlbumState extends Equatable {
  final List<MusicInfo> listMusic;
  final bool loading;
  const AlbumState({this.listMusic = const [], this.loading = false});

  AlbumState copyWith({
    List<MusicInfo>? listMusic,
    bool? loading,
  }) {
    return AlbumState(
      listMusic: listMusic ?? this.listMusic,
      loading: loading ?? this.loading,
    );
  }
  
  @override
  List<Object> get props => [
    listMusic,
    loading,
  ];
}

