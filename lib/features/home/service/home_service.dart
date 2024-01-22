import 'package:music_stream/utils/logic/networking/networking.dart';

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

  ///Get wallpaper from Unsplash Api.
  ///
  final _dio = Dio();

  Future<Response> getWallpaper() async {
    var response = await _dio.get(
      AppUrls.kWallpaper,
      options: Options(
        headers: {
          'Accept-Version': 'v1',
          'Authorization':
              'Client-ID OzIaJET2hDsoo6Di_3vI18NI0c3kXgE7AVyN0lOMA78',
        },
      ),
    );
    // logger.i(response.data, error: 'HomeService getWallpaper() response');
    return response;
  }
}
