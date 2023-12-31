import 'package:music_stream/utils/networking/networking.dart';

class SearchService {
  // Get Search result
  Future<Response> getSearch(String keyword) async {
    Map<String, dynamic>? queryParameters = {"query": keyword};
    var response = await DioClient.dio
        .get(AppUrls.kSearch, queryParameters: queryParameters);
    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception();
    }
  }

  // Get playlist songs.
}
