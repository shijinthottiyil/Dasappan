import 'package:just_audio/just_audio.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class AudioHelper {
  static final player = AudioPlayer();
  static final youtubeExplode = YoutubeExplode();
  static var duration = const Duration();
  static var position = const Duration();

  // <============================================= METHOD FOR GETTING AUDIOURL FROM VIDEO ID============================================>
  static Future<AudioSource?> getAudioSource({required String videoId}) async {
    var audioUrl = "";
    try {
      final StreamManifest manifest =
          await youtubeExplode.videos.streamsClient.getManifest(videoId);
      audioUrl = manifest.audioOnly.withHighestBitrate().url.toString();
      return AudioSource.uri(Uri.parse(audioUrl));
    } catch (e) {
      // log(e.toString());
      return null;
    }
  }
}
