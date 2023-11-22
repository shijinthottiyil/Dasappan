///Old HomeModel Used at the time when only a single ListView.builder is used.

// class HomeModel {
//   String? title;
//   String? videoId;
//   List<Artist>? artists;
//   List<Thumbnail>? thumbnails;

//   HomeModel({
//     this.title,
//     this.videoId,
//     this.artists,
//     this.thumbnails,
//   });

//   factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
//         title: json["title"],
//         videoId: json["videoId"],
//         artists: json["artists"] == null
//             ? []
//             : List<Artist>.from(
//                 json["artists"]!.map((x) => Artist.fromJson(x))),
//         thumbnails: json["thumbnails"] == null
//             ? []
//             : List<Thumbnail>.from(
//                 json["thumbnails"]!.map((x) => Thumbnail.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "title": title,
//         "videoId": videoId,
//         "artists": artists == null
//             ? []
//             : List<dynamic>.from(artists!.map((x) => x.toJson())),
//         "thumbnails": thumbnails == null
//             ? []
//             : List<dynamic>.from(thumbnails!.map((x) => x.toJson())),
//       };
// }

// class Artist {
//   String? name;
//   String? id;

//   Artist({
//     this.name,
//     this.id,
//   });

//   factory Artist.fromJson(Map<String, dynamic> json) => Artist(
//         name: json["name"],
//         id: json["id"],
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "id": id,
//       };
// }

// class Thumbnail {
//   String? url;
//   int? width;
//   int? height;

//   Thumbnail({
//     this.url,
//     this.width,
//     this.height,
//   });

//   factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
//         url: json["url"],
//         width: json["width"],
//         height: json["height"],
//       );

//   Map<String, dynamic> toJson() => {
//         "url": url,
//         "width": width,
//         "height": height,
//       };
// }

///New HomeModel.
class HomeModel {
  String? title;
  List<Content>? contents;

  HomeModel({
    this.title,
    this.contents,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        title: json["title"],
        contents: json["contents"] == null
            ? []
            : List<Content>.from(
                json["contents"]!.map((x) => Content.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "contents": contents == null
            ? []
            : List<dynamic>.from(contents!.map((x) => x.toJson())),
      };
}

class Content {
  String? title;
  String? videoId;
  List<Album>? artists;
  List<Thumbnail>? thumbnails;
  bool? isExplicit;
  Album? album;
  String? playlistId;
  String? description;

  Content({
    this.title,
    this.videoId,
    this.artists,
    this.thumbnails,
    this.isExplicit,
    this.album,
    this.playlistId,
    this.description,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        title: json["title"],
        videoId: json["videoId"],
        artists: json["artists"] == null
            ? []
            : List<Album>.from(json["artists"]!.map((x) => Album.fromJson(x))),
        thumbnails: json["thumbnails"] == null
            ? []
            : List<Thumbnail>.from(
                json["thumbnails"]!.map((x) => Thumbnail.fromJson(x))),
        isExplicit: json["isExplicit"],
        album: json["album"] == null ? null : Album.fromJson(json["album"]),
        playlistId: json["playlistId"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "videoId": videoId,
        "artists": artists == null
            ? []
            : List<dynamic>.from(artists!.map((x) => x.toJson())),
        "thumbnails": thumbnails == null
            ? []
            : List<dynamic>.from(thumbnails!.map((x) => x.toJson())),
        "isExplicit": isExplicit,
        "album": album?.toJson(),
        "playlistId": playlistId,
        "description": description,
      };
}

class Album {
  String? name;
  String? id;

  Album({
    this.name,
    this.id,
  });

  factory Album.fromJson(Map<String, dynamic> json) => Album(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}

class Thumbnail {
  String? url;
  int? width;
  int? height;

  Thumbnail({
    this.url,
    this.width,
    this.height,
  });

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        url: json["url"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "width": width,
        "height": height,
      };
}
