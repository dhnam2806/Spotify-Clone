part of 'home_bloc.dart';

final class HomeState extends Equatable {
  final List<AlbumInfo> newRealease;
  final List<AlbumInfo> albumForYou;
  final bool loading;

  const HomeState({this.newRealease = const [], this.albumForYou = const [] , this.loading = false});

  HomeState copyWith({
    List<AlbumInfo>? newRealease,
    List<AlbumInfo>? albumForYou,
    bool? loading,
  }) {
    return HomeState(
      newRealease: newRealease ?? this.newRealease,
      albumForYou: albumForYou ?? this.albumForYou,
      loading: loading ?? this.loading,
    );
  }
  
  @override
  List<Object> get props => [
    newRealease,
    albumForYou,
    loading,
  ];
}


