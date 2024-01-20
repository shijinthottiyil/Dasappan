import 'package:music_stream/utils/logic/networking/networking.dart';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: AppUrls.kBaseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      responseType: ResponseType.json,
      contentType: "application/json",
    ),
  );
}
