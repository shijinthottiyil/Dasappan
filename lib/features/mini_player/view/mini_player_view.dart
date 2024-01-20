import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_stream/features/bottom/view/bottom_view.dart';
import 'package:music_stream/features/now_play/view/widgets/play_pause_button.dart';
import 'package:music_stream/utils/logic/helpers/audio_helper.dart';
import 'package:music_stream/utils/ui/constants/constants.dart';
import 'package:music_stream/utils/ui/shared_widgets/shared_widgets.dart';

class MiniPlayerView extends StatelessWidget {
  const MiniPlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: pc.open,
        child: Container(
          decoration: BoxDecoration(
            color: context.theme.scaffoldBackgroundColor,
            border: _getBorder(context),
          ),
          child: AudioHelper.playlistList.isEmpty
              ? null
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.w),
                  child: StreamBuilder(
                    stream: AudioHelper.player.currentIndexStream,
                    builder: (context, currentIndex) {
                      if (currentIndex.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Row(
                        children: [
                          ImageLoaderWidget(
                            imageUrl: AudioHelper.playlistList
                                .elementAt(currentIndex.data!)
                                .thumbnail!
                                .last
                                .url
                                .toString(),
                            width: 60.w,
                            height: 60.w,
                            fit: BoxFit.cover,
                            borderRadius: BorderRadius.circular(10).r,
                          ),
                          SizedBox(width: 5.w),
                          Expanded(
                            child: DefaultTextStyle(
                              style: context.textTheme.labelLarge!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              child: Text(
                                AudioHelper.playlistList
                                    .elementAt(currentIndex.data!)
                                    .title
                                    .toString(),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: StreamBuilder<PlayerState>(
                              stream: AudioHelper.player.playerStateStream,
                              builder: (_, snapshot) {
                                final playerState = snapshot.data;
                                return PlayPauseButton(
                                    playerState: playerState);
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }

  //Helper Fun. which will return Border Based on Theme.
  Border _getBorder(BuildContext context) {
    const width = 0.2;
    var color = context.isDarkMode
        ? AppColors.kWhite
        : /* AppColors.kBlack*/ Colors.transparent;
    return Border(
      top: BorderSide(width: width, color: color),
      bottom: BorderSide(width: width, color: color),
    );
  }
}
