import 'package:music_stream/utils/logic/networking/networking.dart';

class ArtistService {
  ///Method to fetch all songs of the corresponding Artist by using the id to display in the ArtistView.[kArtist].
  Future<Response> getArtistSongs(String id) async {
    Map<String, dynamic>? queryParameters = {
      "id": id,
      'lang': 'en',
    };
    var response = await DioClient.dio
        .get(AppUrls.kArtist, queryParameters: queryParameters);
    // logger.i(response.data, error: 'ArtistService getArtistSongs() response');
    return response;
  }
}
