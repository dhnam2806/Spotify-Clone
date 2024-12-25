import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'album_dto.g.dart';

@JsonSerializable()
class AlbumDto {
  @JsonKey(name: "albums")
  final Albums albums;

  AlbumDto({
    required this.albums,
  });

  factory AlbumDto.fromJson(Map<String, dynamic> json) => _$AlbumDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumDtoToJson(this);
}

@JsonSerializable()
class Albums {
  @JsonKey(name: "href")
  final String href;
  @JsonKey(name: "items")
  final List<Item> items;
  @JsonKey(name: "limit")
  final int limit;
  @JsonKey(name: "next")
  final String next;
  @JsonKey(name: "offset")
  final int offset;
  @JsonKey(name: "previous")
  final dynamic previous;
  @JsonKey(name: "total")
  final int total;

  Albums({
    required this.href,
    required this.items,
    required this.limit,
    required this.next,
    required this.offset,
    required this.previous,
    required this.total,
  });

  factory Albums.fromJson(Map<String, dynamic> json) => _$AlbumsFromJson(json);

  Map<String, dynamic> toJson() => _$AlbumsToJson(this);
}

@JsonSerializable()
class Item {
  @JsonKey(name: "album_type")
  final AlbumTypeEnum albumType;
  @JsonKey(name: "artists")
  final List<Artist> artists;
  @JsonKey(name: "available_markets")
  final List<String> availableMarkets;
  @JsonKey(name: "external_urls")
  final ExternalUrls externalUrls;
  @JsonKey(name: "href")
  final String href;
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "images")
  final List<Image> images;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "release_date")
  final DateTime releaseDate;
  @JsonKey(name: "release_date_precision")
  final ReleaseDatePrecision releaseDatePrecision;
  @JsonKey(name: "total_tracks")
  final int totalTracks;
  @JsonKey(name: "type")
  final AlbumTypeEnum type;
  @JsonKey(name: "uri")
  final String uri;

  Item({
    required this.albumType,
    required this.artists,
    required this.availableMarkets,
    required this.externalUrls,
    required this.href,
    required this.id,
    required this.images,
    required this.name,
    required this.releaseDate,
    required this.releaseDatePrecision,
    required this.totalTracks,
    required this.type,
    required this.uri,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  Map<String, dynamic> toJson() => _$ItemToJson(this);
}

enum AlbumTypeEnum {
  @JsonValue("album")
  ALBUM,
  @JsonValue("ep")
  EP,
  @JsonValue("single")
  SINGLE
}

final albumTypeEnumValues =
    EnumValues({"album": AlbumTypeEnum.ALBUM, "ep": AlbumTypeEnum.EP, "single": AlbumTypeEnum.SINGLE});

@JsonSerializable()
class Artist {
  @JsonKey(name: "external_urls")
  final ExternalUrls externalUrls;
  @JsonKey(name: "href")
  final String href;
  @JsonKey(name: "id")
  final String id;
  @JsonKey(name: "name")
  final String name;
  @JsonKey(name: "type")
  final ArtistType type;
  @JsonKey(name: "uri")
  final String uri;

  Artist({
    required this.externalUrls,
    required this.href,
    required this.id,
    required this.name,
    required this.type,
    required this.uri,
  });

  factory Artist.fromJson(Map<String, dynamic> json) => _$ArtistFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistToJson(this);
}

@JsonSerializable()
class ExternalUrls {
  @JsonKey(name: "spotify")
  final String spotify;

  ExternalUrls({
    required this.spotify,
  });

  factory ExternalUrls.fromJson(Map<String, dynamic> json) => _$ExternalUrlsFromJson(json);

  Map<String, dynamic> toJson() => _$ExternalUrlsToJson(this);
}

enum ArtistType {
  @JsonValue("artist")
  ARTIST
}

final artistTypeValues = EnumValues({"artist": ArtistType.ARTIST});

@JsonSerializable()
class Image {
  @JsonKey(name: "height")
  final int height;
  @JsonKey(name: "url")
  final String url;
  @JsonKey(name: "width")
  final int width;

  Image({
    required this.height,
    required this.url,
    required this.width,
  });

  factory Image.fromJson(Map<String, dynamic> json) => _$ImageFromJson(json);

  Map<String, dynamic> toJson() => _$ImageToJson(this);
}

enum ReleaseDatePrecision {
  @JsonValue("day")
  DAY
}

final releaseDatePrecisionValues = EnumValues({"day": ReleaseDatePrecision.DAY});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
