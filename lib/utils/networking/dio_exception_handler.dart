import 'package:dio/dio.dart';
import 'package:music_stream/utils/networking/app_popups.dart';

class DioExceptionHandler {
  static void dioError(DioExceptionType type) {
    AppPopups.cancelDialog();
    switch (type) {
      case DioExceptionType.connectionTimeout:
        AppPopups.errorSnackbar(
            title: 'DioException', message: 'connection timeout');
        break;
      case DioExceptionType.sendTimeout:
        AppPopups.errorSnackbar(title: 'DioException', message: 'send timeout');
        break;
      case DioExceptionType.receiveTimeout:
        AppPopups.errorSnackbar(
            title: 'DioException', message: 'receive timeout');
        break;
      case DioExceptionType.badCertificate:
        AppPopups.errorSnackbar(
            title: 'DioException', message: 'bad certificate');
        break;
      case DioExceptionType.badResponse:
        AppPopups.errorSnackbar(title: 'DioException', message: 'bad response');
        break;
      case DioExceptionType.cancel:
        AppPopups.errorSnackbar(
            title: 'DioException', message: 'request cancelled');
        break;
      case DioExceptionType.connectionError:
        AppPopups.errorSnackbar(
            title: 'DioException', message: 'connection error');
        break;
      case DioExceptionType.unknown:
        AppPopups.errorSnackbar(title: 'DioException', message: 'unknown');
        break;
    }
  }
}
