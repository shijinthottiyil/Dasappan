import 'package:dio/dio.dart';
import 'package:music_stream/utils/constants/constants.dart';
import 'package:music_stream/utils/networking/dio_client.dart';

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
}
