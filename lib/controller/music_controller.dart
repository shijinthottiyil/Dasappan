import 'package:just_audio/just_audio.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class MusicController {
  static final player = AudioPlayer();
  static final youtubeExplode = YoutubeExplode();
  static var duration = const Duration();
  static var position = const Duration();

  // <============================ PLAY AND PAUSE =========================>
  // static void playOrPause() {
  //   if (player.playing) {
  //     player.pause();
  //   } else {
  //     player.play();
  //   }
  // }
}
