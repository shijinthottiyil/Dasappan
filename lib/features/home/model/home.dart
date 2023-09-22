import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_stream/features/home/model/home_model.dart';

class Home {
// List of HomeModel
  var homeList = List<HomeModel>.empty(growable: true).obs;

// Refer just audio in pub
  List<AudioSource> audioSourceList = [];
  ConcatenatingAudioSource playlist = ConcatenatingAudioSource(
    useLazyPreparation: true,
    shuffleOrder: DefaultShuffleOrder(),
    children: [],
  );
}
