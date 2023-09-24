import 'package:dio/dio.dart';
import 'package:music_stream/utils/constants/constants.dart';
import 'package:music_stream/utils/networking/dio_client.dart';

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
}
