import 'package:music_stream/utils/networking/networking.dart';

class DioClient {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: AppUrls.kBaseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      responseType: ResponseType.json,
      contentType: "application/json",
    ),
  );
}
