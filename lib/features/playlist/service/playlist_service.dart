import 'package:music_stream/utils/logic/networking/networking.dart';

class PlaylistService {
  ///Method to fetch all songs to display in the playlist view.[kPlaylistList].
  Future<Response> getPlaylistList(String? browseId) async {
    Map<String, dynamic>? queryParameters = {"id": browseId};
    var response = await DioClient.dio
        .get(AppUrls.kPlaylistList, queryParameters: queryParameters);
    // logger.i(response.data,
    //     error: 'PlaylistService getPlaylistList() response');
    return response;
  }
}
