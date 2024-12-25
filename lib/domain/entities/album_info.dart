class AlbumInfo {
  final String? id;
  final String? name;
  final String? artist;
  final String? url;
  final String? image;
  final String? thumbnailImage;

  AlbumInfo({
    this.id,
    this.name,
    this.artist,
    this.url,
    this.image,
    this.thumbnailImage,
  });

  factory AlbumInfo.fromJson(Map<String, dynamic> json) {
    return AlbumInfo(
      id: json['id'],
      name: json['name'],
      artist: json['artist'],
      url: json['url'],
      image: json['image'].last['#text'],
      thumbnailImage: json['image'].first['#text'],
    );
  }
}
