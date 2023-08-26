class SearchModel {
  SearchModel({
    required this.videoId,
    required this.title,
    required this.thumbnails,
    required this.artists,
  });

  final String videoId;
  final String title;
  final String thumbnails;
  final String artists;

  factory SearchModel.fromJson(Map<String, dynamic> json, int index) {
    final data = json["songs"][index];
    return SearchModel(
      videoId: data["videoId"] ?? "",
      title: data["title"] ?? "",
      thumbnails: data["thumbnails"][1]["url"] ?? "",
      artists: data["artists"][0]["name"] ?? "",
    );
  }

  @override
  String toString() {
    return {
      "videoId": videoId,
      "title": title,
      "thumbnails": thumbnails,
      "artists": artists,
    }.toString();
  }
}
