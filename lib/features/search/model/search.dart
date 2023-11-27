import 'package:get/get.dart';
import 'package:music_stream/features/search/model/playlist_model.dart';
import 'package:music_stream/features/search/model/search_model.dart';

///Expirementing Voice Search.
///
import 'package:speech_to_text/speech_to_text.dart';

class Search {
  // List of SearchModel
  var searchList = List<SearchModel>.empty(growable: true).obs;

  // List of PlaylistModel
  var playlistModelList = List<PlaylistModel>.empty(growable: true).obs;

  ///Expirementing Voice Search.
  ///Instance of SpeechToText.
  ///
  var speechToText = SpeechToText();

  ///Variable to keepTrack if the user has granted premission for voice search.
  ///
  var isSpeechGranted = false.obs;

  ///Variable to keepTrack of the SpeechData.
  ///
  var speechData = ''.obs;

  ///Variable to keepTrack if the Listening to the user.
  ///
  var isListening = false.obs;

  bool isVoiceSearchInProgress = false;
}
