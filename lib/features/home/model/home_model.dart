class HomeModel {
  String? title;
  String? videoId;
  List<Artist>? artists;
  List<Thumbnail>? thumbnails;

  HomeModel({
    this.title,
    this.videoId,
    this.artists,
    this.thumbnails,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
        title: json["title"],
        videoId: json["videoId"],
        artists: json["artists"] == null
            ? []
            : List<Artist>.from(
                json["artists"]!.map((x) => Artist.fromJson(x))),
        thumbnails: json["thumbnails"] == null
            ? []
            : List<Thumbnail>.from(
                json["thumbnails"]!.map((x) => Thumbnail.fromJson(x))),
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
      };
}

class Artist {
  String? name;
  String? id;

  Artist({
    this.name,
    this.id,
  });

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
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
