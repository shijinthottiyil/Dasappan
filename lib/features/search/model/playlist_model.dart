class PlaylistModel {
  String? title;
  String? browseId;
  List<Thumbnail>? thumbnails;

  PlaylistModel({
    this.title,
    this.browseId,
    this.thumbnails,
  });

  factory PlaylistModel.fromJson(Map<String, dynamic> json) => PlaylistModel(
        title: json["title"],
        browseId: json["browseId"],
        thumbnails: json["thumbnails"] == null
            ? []
            : List<Thumbnail>.from(
                json["thumbnails"]!.map((x) => Thumbnail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "browseId": browseId,
        "thumbnails": thumbnails == null
            ? []
            : List<dynamic>.from(thumbnails!.map((x) => x.toJson())),
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
