import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_stream/features/now_playing/widget/reorder_song.dart';

final nowProvider = ChangeNotifierProvider<NowPlayProvider>((ref) {
  return NowPlayProvider();
});

class NowPlayProvider with ChangeNotifier {
  // METHOD FOR SHOWING DISPLAYING BOTTOMSHEET AND DISPLAY QUEUE DATA
  // <============================================== METHOD FOR SHOWING SHOWMODAL BOTTOMSHEET===========================================>
  Future<void> getModelSheet({required BuildContext context}) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      barrierColor: Colors.black,
      backgroundColor: Colors.black,
      context: context,
      builder: (context) {
        return ReorderSong();
      },
    );
  }
}
