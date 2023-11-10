import 'package:get/get.dart';
import 'package:music_stream/features/search/model/playlist_model.dart';
import 'package:music_stream/features/search/model/search_model.dart';

class Search {
  // List of SearchModel
  var searchList = List<SearchModel>.empty(growable: true).obs;

  // List of PlaylistModel
  var playlistModelList = List<PlaylistModel>.empty(growable: true).obs;
}
