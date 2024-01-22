import 'package:get/get.dart';
import 'package:music_stream/features/artist/model/artist.dart';
import 'package:music_stream/features/artist/service/artist_service.dart';
import 'package:music_stream/features/home/model/playlist_model.dart';
import 'package:music_stream/utils/logic/networking/networking.dart';

class ArtistController extends GetxController {
  ///Variables.
  final artist = Artist();

  ///Service.
  final service = ArtistService();

  ///Method to fetch all songs of the corresponding Artist by using the id to display in the ArtistView.[kArtist].
  Future<void> getArtistSongs(String artistId) async {
    try {
      AppPopups.showDialog();

//Implimenting PersistentBottomNavigation Bar And Find a Small Bug and Fixing That.
      artist.artistList.value = [];

      var response = await service.getArtistSongs(artistId);
      // logger.i(response, error: 'ArtistController getArtistSongs() response');
      AppPopups.cancelDialog();
      List trackList = response.data['tracks'];
      // logger.f(trackList,
      //     error: 'PlaylistController getPlaylistList() trackList');
      for (var i = 0; i < trackList.length; i++) {
        var json = trackList[i];
        artist.artistList.add(PlaylistModel.fromJson(json));
      }
    } on DioException catch (dioError) {
      DioExceptionHandler.dioError(dioError.type);
    } catch (err) {
      AppPopups.cancelDialog();
      logger.e(err, error: 'ArtistController getArtistSongs() catch');
    }
  }
}
