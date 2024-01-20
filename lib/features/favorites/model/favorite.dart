import 'package:get/get.dart';
import 'package:music_stream/features/favorites/model/favorite_model.dart';

class Favorite {
  ///List to store songIds in the Favorites.
  var favoriteDbIdsList = <String>[].obs;

  ///List to store SongInFormation in the Favorites.
  var favoriteModelList = <FavoriteModel>[].obs;
}
