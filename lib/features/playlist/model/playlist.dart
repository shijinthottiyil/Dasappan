import 'package:get/get.dart';
import 'package:music_stream/features/home/model/playlist_model.dart';

class Playlist {
  ///Variable to store List<HomeModel> which is actually the result for playlist songs.
  var playlistList = List<PlaylistModel>.empty(growable: true).obs;
}
