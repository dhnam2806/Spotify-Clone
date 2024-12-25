import 'dart:convert';

class RealeaseDto {
    final Albums albums;

    RealeaseDto({
        required this.albums,
    });

    factory RealeaseDto.fromJson(String str) => RealeaseDto.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory RealeaseDto.fromMap(Map<String, dynamic> json) => RealeaseDto(
        albums: Albums.fromMap(json["albums"]),
    );

    Map<String, dynamic> toMap() => {
        "albums": albums.toMap(),
    };
}

class Albums {
    final String? href;
    final List<Item>? items;
    final int? limit;
    final String? next;
    final int? offset;
    final dynamic previous;
    final int? total;

    Albums({
        required this.href,
        required this.items,
        required this.limit,
        required this.next,
        required this.offset,
        required this.previous,
        required this.total,
    });

    factory Albums.fromJson(String str) => Albums.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Albums.fromMap(Map<String, dynamic> json) => Albums(
        href: json["href"],
        items: List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
        limit: json["limit"],
        next: json["next"],
        offset: json["offset"],
        previous: json["previous"],
        total: json["total"],
    );

    Map<String, dynamic> toMap() => {
        "href": href,
        "items": List<dynamic>.from(items!.map((x) => x.toMap())),
        "limit": limit,
        "next": next,
        "offset": offset,
        "previous": previous,
        "total": total,
    };
}

class Item {
    final AlbumTypeEnum? albumType;
    final List<Artist>? artists;
    final List<String>? availableMarkets;
    final ExternalUrls? externalUrls;
    final String? href;
    final String? id;
    final List<Image>? images;
    final String? name;
    final DateTime? releaseDate;
    final ReleaseDatePrecision? releaseDatePrecision;
    final int? totalTracks;
    final AlbumTypeEnum? type;
    final String? uri;

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

    factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Item.fromMap(Map<String, dynamic> json) => Item(
        albumType: albumTypeEnumValues.map[json["album_type"]]!,
        artists: List<Artist>.from(json["artists"].map((x) => Artist.fromMap(x))),
        availableMarkets: List<String>.from(json["available_markets"].map((x) => x)),
        externalUrls: ExternalUrls.fromMap(json["external_urls"]),
        href: json["href"],
        id: json["id"],
        images: List<Image>.from(json["images"].map((x) => Image.fromMap(x))),
        name: json["name"],
        releaseDate: DateTime.parse(json["release_date"]),
        releaseDatePrecision: releaseDatePrecisionValues.map[json["release_date_precision"]]!,
        totalTracks: json["total_tracks"],
        type: albumTypeEnumValues.map[json["type"]]!,
        uri: json["uri"],
    );

    Map<String, dynamic> toMap() => {
        "album_type": albumTypeEnumValues.reverse[albumType],
        "artists": List<dynamic>.from(artists!.map((x) => x.toMap())),
        "available_markets": List<dynamic>.from(availableMarkets!.map((x) => x)),
        "external_urls": externalUrls!.toMap(),
        "href": href,
        "id": id,
        "images": List<dynamic>.from(images!.map((x) => x.toMap())),
        "name": name,
        "release_date": "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "release_date_precision": releaseDatePrecisionValues.reverse[releaseDatePrecision],
        "total_tracks": totalTracks,
        "type": albumTypeEnumValues.reverse[type],
        "uri": uri,
    };
}

enum AlbumTypeEnum {
    ALBUM,
    EP,
    SINGLE
}

final albumTypeEnumValues = EnumValues({
    "album": AlbumTypeEnum.ALBUM,
    "ep": AlbumTypeEnum.EP,
    "single": AlbumTypeEnum.SINGLE
});

class Artist {
    final ExternalUrls? externalUrls;
    final String? href;
    final String? id;
    final String? name;
    final ArtistType? type;
    final String? uri;

    Artist({
        required this.externalUrls,
        required this.href,
        required this.id,
        required this.name,
        required this.type,
        required this.uri,
    });

    factory Artist.fromJson(String str) => Artist.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Artist.fromMap(Map<String, dynamic> json) => Artist(
        externalUrls: ExternalUrls.fromMap(json["external_urls"]),
        href: json["href"],
        id: json["id"],
        name: json["name"],
        type: artistTypeValues.map[json["type"]]!,
        uri: json["uri"],
    );

    Map<String, dynamic> toMap() => {
        "external_urls": externalUrls!.toMap(),
        "href": href,
        "id": id,
        "name": name,
        "type": artistTypeValues.reverse[type],
        "uri": uri,
    };
}

class ExternalUrls {
    final String? spotify;

    ExternalUrls({
        required this.spotify,
    });

    factory ExternalUrls.fromJson(String str) => ExternalUrls.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ExternalUrls.fromMap(Map<String, dynamic> json) => ExternalUrls(
        spotify: json["spotify"],
    );

    Map<String, dynamic> toMap() => {
        "spotify": spotify,
    };
}

enum ArtistType {
    ARTIST
}

final artistTypeValues = EnumValues({
    "artist": ArtistType.ARTIST
});

class Image {
    final int? height;
    final String? url;
    final int? width;

    Image({
        required this.height,
        required this.url,
        required this.width,
    });

    factory Image.fromJson(String str) => Image.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Image.fromMap(Map<String, dynamic> json) => Image(
        height: json["height"],
        url: json["url"],
        width: json["width"],
    );

    Map<String, dynamic> toMap() => {
        "height": height,
        "url": url,
        "width": width,
    };
}

enum ReleaseDatePrecision {
    DAY
}

final releaseDatePrecisionValues = EnumValues({
    "day": ReleaseDatePrecision.DAY
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
