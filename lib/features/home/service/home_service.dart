import 'package:music_stream/utils/networking/networking.dart';

class HomeService {
  // getQuickpicks
  Future<Response> getQuickpicks() async {
    var response = await DioClient.dio.get(AppUrls.kHome);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception();
    }
  }

  // Get Playlist
  Future<Response> getPlaylist({String? videoId}) async {
    Map<String, dynamic>? queryParameters = {"videoId": videoId, "limit": 10};
    var response = await DioClient.dio
        .get(AppUrls.kPlaylist, queryParameters: queryParameters);

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception();
    }
  }
}
