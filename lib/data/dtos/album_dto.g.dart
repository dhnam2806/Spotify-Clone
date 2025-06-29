// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumDto _$AlbumDtoFromJson(Map<String, dynamic> json) => AlbumDto(
      albums: Albums.fromJson(json['albums'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AlbumDtoToJson(AlbumDto instance) => <String, dynamic>{
      'albums': instance.albums,
    };

Albums _$AlbumsFromJson(Map<String, dynamic> json) => Albums(
      href: json['href'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      limit: (json['limit'] as num).toInt(),
      next: json['next'] as String,
      offset: (json['offset'] as num).toInt(),
      previous: json['previous'],
      total: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$AlbumsToJson(Albums instance) => <String, dynamic>{
      'href': instance.href,
      'items': instance.items,
      'limit': instance.limit,
      'next': instance.next,
      'offset': instance.offset,
      'previous': instance.previous,
      'total': instance.total,
    };

Item _$ItemFromJson(Map<String, dynamic> json) => Item(
      albumType: $enumDecode(_$AlbumTypeEnumEnumMap, json['album_type']),
      artists: (json['artists'] as List<dynamic>)
          .map((e) => Artist.fromJson(e as Map<String, dynamic>))
          .toList(),
      availableMarkets: (json['available_markets'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      externalUrls:
          ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>),
      href: json['href'] as String,
      id: json['id'] as String,
      images: (json['images'] as List<dynamic>)
          .map((e) => Image.fromJson(e as Map<String, dynamic>))
          .toList(),
      name: json['name'] as String,
      releaseDate: DateTime.parse(json['release_date'] as String),
      releaseDatePrecision: $enumDecode(
          _$ReleaseDatePrecisionEnumMap, json['release_date_precision']),
      totalTracks: (json['total_tracks'] as num).toInt(),
      type: $enumDecode(_$AlbumTypeEnumEnumMap, json['type']),
      uri: json['uri'] as String,
    );

Map<String, dynamic> _$ItemToJson(Item instance) => <String, dynamic>{
      'album_type': _$AlbumTypeEnumEnumMap[instance.albumType]!,
      'artists': instance.artists,
      'available_markets': instance.availableMarkets,
      'external_urls': instance.externalUrls,
      'href': instance.href,
      'id': instance.id,
      'images': instance.images,
      'name': instance.name,
      'release_date': instance.releaseDate.toIso8601String(),
      'release_date_precision':
          _$ReleaseDatePrecisionEnumMap[instance.releaseDatePrecision]!,
      'total_tracks': instance.totalTracks,
      'type': _$AlbumTypeEnumEnumMap[instance.type]!,
      'uri': instance.uri,
    };

const _$AlbumTypeEnumEnumMap = {
  AlbumTypeEnum.ALBUM: 'album',
  AlbumTypeEnum.EP: 'ep',
  AlbumTypeEnum.SINGLE: 'single',
};

const _$ReleaseDatePrecisionEnumMap = {
  ReleaseDatePrecision.DAY: 'day',
};

Artist _$ArtistFromJson(Map<String, dynamic> json) => Artist(
      externalUrls:
          ExternalUrls.fromJson(json['external_urls'] as Map<String, dynamic>),
      href: json['href'] as String,
      id: json['id'] as String,
      name: json['name'] as String,
      type: $enumDecode(_$ArtistTypeEnumMap, json['type']),
      uri: json['uri'] as String,
    );

Map<String, dynamic> _$ArtistToJson(Artist instance) => <String, dynamic>{
      'external_urls': instance.externalUrls,
      'href': instance.href,
      'id': instance.id,
      'name': instance.name,
      'type': _$ArtistTypeEnumMap[instance.type]!,
      'uri': instance.uri,
    };

const _$ArtistTypeEnumMap = {
  ArtistType.ARTIST: 'artist',
};

ExternalUrls _$ExternalUrlsFromJson(Map<String, dynamic> json) => ExternalUrls(
      spotify: json['spotify'] as String,
    );

Map<String, dynamic> _$ExternalUrlsToJson(ExternalUrls instance) =>
    <String, dynamic>{
      'spotify': instance.spotify,
    };

Image _$ImageFromJson(Map<String, dynamic> json) => Image(
      height: (json['height'] as num).toInt(),
      url: json['url'] as String,
      width: (json['width'] as num).toInt(),
    );

Map<String, dynamic> _$ImageToJson(Image instance) => <String, dynamic>{
      'height': instance.height,
      'url': instance.url,
      'width': instance.width,
    };
