import 'package:get/get.dart';
import 'package:music_stream/utils/logic/helpers/audio_helper.dart';

class NowController extends GetxController {
  ///Method to Reorder The QueueList[AudioHelper -> PlaylistList and playlist] when user reorder the queue.
  ///
  void reorderQueue(int index, int newIndex) {
    var removedSong = AudioHelper.playlistList.removeAt(index);
    AudioHelper.playlistList.insertAll(newIndex, [removedSong]);
    AudioHelper.playlist.value.move(index, newIndex);
  }
}
