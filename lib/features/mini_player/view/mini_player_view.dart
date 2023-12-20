import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_stream/features/now_play/view/widgets/play_pause_button.dart';
import 'package:music_stream/utils/constants/constants.dart';
import 'package:music_stream/utils/helpers/audio_helper.dart';

class MiniPlayerView extends StatelessWidget {
  const MiniPlayerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.scaffoldBackgroundColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7.w),
        child: StreamBuilder(
          stream: AudioHelper.player.currentIndexStream,
          builder: (context, currentIndex) {
            if (currentIndex.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Obx(
              () => Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10).r,
                    child: FadeInImage(
                      placeholder: AssetImage(
                        AppAssets.kLenin,
                      ),
                      image: NetworkImage(
                        AudioHelper.playlistList
                            .elementAt(currentIndex.data!)
                            .thumbnail!
                            .last
                            .url
                            .toString(),
                      ),
                      imageErrorBuilder: (context, error, stackTrace) =>
                          Image.asset(
                        AppAssets.kLenin,
                        width: 60.w,
                        height: 60.w,
                        fit: BoxFit.cover,
                      ),
                      width: 60.w,
                      height: 60.w,
                      fit: BoxFit.cover,
                      placeholderFit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 5.w),
                  Expanded(
                    child: Text(
                      AudioHelper.playlistList
                          .elementAt(currentIndex.data!)
                          .title
                          .toString(),
                      style: AppTypography.kBold12,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: StreamBuilder<PlayerState>(
                      stream: AudioHelper.player.playerStateStream,
                      builder: (_, snapshot) {
                        final playerState = snapshot.data;
                        return PlayPauseButton(playerState: playerState);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
