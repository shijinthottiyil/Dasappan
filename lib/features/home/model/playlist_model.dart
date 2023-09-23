class PlaylistModel {
  String? videoId;
  String? title;
  List<Thumbnail>? thumbnail;

  PlaylistModel({
    this.videoId,
    this.title,
    this.thumbnail,
  });

  factory PlaylistModel.fromJson(Map<String, dynamic> json) => PlaylistModel(
        videoId: json["videoId"],
        title: json["title"],
        thumbnail: json["thumbnail"] == null
            ? []
            : List<Thumbnail>.from(
                json["thumbnail"]!.map((x) => Thumbnail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "videoId": videoId,
        "title": title,
        "thumbnail": thumbnail == null
            ? []
            : List<dynamic>.from(thumbnail!.map((x) => x.toJson())),
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
