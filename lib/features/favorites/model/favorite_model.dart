class FavoriteModel {
  final String videoId;
  final String videoTitle;
  final String videoThumbnail;

  const FavoriteModel({
    required this.videoId,
    required this.videoTitle,
    required this.videoThumbnail,
  });

  // Constructor to create a FavoriteModel object from a database row
  factory FavoriteModel.fromMap(Map<String, dynamic> map) {
    return FavoriteModel(
      videoId: map['videoId'] as String,
      videoTitle: map['videoTitle'] as String,
      videoThumbnail: map['videoThumbnail'] as String,
    );
  }

  // Convert the model to a Map for database insertion
  Map<String, dynamic> toMap() {
    return {
      'videoId': videoId,
      'videoTitle': videoTitle,
      'videoThumbnail': videoThumbnail,
    };
  }

  @override
  String toString() {
    return 'FavoriteModel{videoId: $videoId, videoTitle: $videoTitle, videoThumbnail: $videoThumbnail}';
  }
}
