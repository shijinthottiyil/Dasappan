class ArtistModel {
  String? category;
  String? resultType;
  String? artist;
  String? shuffleId;
  String? radioId;
  String? browseId;
  List<Thumbnail>? thumbnails;

  ArtistModel({
    this.category,
    this.resultType,
    this.artist,
    this.shuffleId,
    this.radioId,
    this.browseId,
    this.thumbnails,
  });

  factory ArtistModel.fromJson(Map<String, dynamic> json) => ArtistModel(
        category: json["category"],
        resultType: json["resultType"],
        artist: json["artist"],
        shuffleId: json["shuffleId"],
        radioId: json["radioId"],
        browseId: json["browseId"],
        thumbnails: json["thumbnails"] == null
            ? []
            : List<Thumbnail>.from(
                json["thumbnails"]!.map((x) => Thumbnail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "resultType": resultType,
        "artist": artist,
        "shuffleId": shuffleId,
        "radioId": radioId,
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
