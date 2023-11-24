class WallpaperModel {
  Urls? urls;

  WallpaperModel({
    this.urls,
  });

  factory WallpaperModel.fromJson(Map<String, dynamic> json) => WallpaperModel(
        urls: json["urls"] == null ? null : Urls.fromJson(json["urls"]),
      );

  Map<String, dynamic> toJson() => {
        "urls": urls?.toJson(),
      };
}

class Urls {
  String? full;

  Urls({
    this.full,
  });

  factory Urls.fromJson(Map<String, dynamic> json) => Urls(
        full: json["full"],
      );

  Map<String, dynamic> toJson() => {
        "full": full,
      };
}
