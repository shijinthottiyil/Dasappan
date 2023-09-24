import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:music_stream/features/home/model/playlist_model.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class AudioHelper {
  static final player = AudioPlayer();
  static final youtubeExplode = YoutubeExplode();
  static var duration = const Duration();
  static var position = const Duration();

  // Playlist
  static var playlist = ConcatenatingAudioSource(
    useLazyPreparation: true,
    shuffleOrder: DefaultShuffleOrder(),
    children: [],
  ).obs;

// Playlist List
  static var playlistList = List<PlaylistModel>.empty(growable: true).obs;

  // <============================================= METHOD FOR GETTING AUDIOURL FROM VIDEO ID============================================>
  static Future<Uri?> getAudioUri({
    required String videoId,
  }) async {
    var audioUrl = "";
    try {
      final StreamManifest manifest =
          await youtubeExplode.videos.streamsClient.getManifest(videoId);
      audioUrl = manifest.audioOnly.withHighestBitrate().url.toString();
      return Uri.parse(audioUrl);
    } catch (e) {
      // log(e.toString());
      return null;
    }
  }
}
