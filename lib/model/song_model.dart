class SongModel {
  SongModel({
    required this.title,
    required this.videoId,
    required this.artists,
    required this.thumbnails,
  });

  final String title;
  final String videoId;
  final String artists;
  final String thumbnails;

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      title: json["title"],
      videoId: json["videoId"],
      artists: json["artists"][0]["name"],
      thumbnails: json["thumbnails"][1]["url"],
    );
  }

  @override
  String toString() {
    return {
      "title": title,
      "videoId": videoId,
      "artists": artists,
      "thumbnails": thumbnails,
    }.toString();
  }
}
