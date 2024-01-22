import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/now_play/controller/now_controller.dart';
import 'package:music_stream/utils/logic/helpers/audio_helper.dart';
import 'package:music_stream/utils/ui/constants/app_colors.dart';
import 'package:music_stream/utils/ui/constants/app_spacing.dart';
import 'package:music_stream/utils/ui/constants/app_texts.dart';
import 'package:music_stream/utils/ui/shared_widgets/image_loader_widget.dart';

class SongQueueView extends StatelessWidget {
  const SongQueueView({super.key});

  @override
  Widget build(BuildContext context) {
    final nowPlayC = Get.put(NowController());
    return Obx(
      () => Scrollbar(
        child: Column(
          children: [
            Expanded(
              child: ReorderableList(
                itemBuilder: (context, index) {
                  var data = AudioHelper.playlistList[index];
                  return Material(
                    color: Colors.transparent,
                    key: Key('$index'),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${index + 1}.',
                            style: context.textTheme.labelLarge,
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            onTap: () {
                              // _playlistC.playSelected(index);
                            },
                            contentPadding: EdgeInsets.all(10.r),
                            leading: ImageLoaderWidget(
                              borderRadius: BorderRadius.circular(10.r),
                              imageUrl: data.thumbnail!.last.url!,
                              width: 60.w,
                              height: 60.w,
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              data.title ?? AppTexts.kTitle,
                              style: context.textTheme.titleMedium,
                            ),
                            trailing: StreamBuilder(
                              stream: AudioHelper.player.currentIndexStream,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  if (index == snapshot.data) {
                                    return Container(
                                      width: 30.w,
                                      height: 30.w,
                                      decoration: BoxDecoration(
                                        color: AppColors.kGreen,
                                        borderRadius:
                                            BorderRadius.circular(5).r,
                                      ),
                                      child: const Icon(
                                        Icons.play_circle_rounded,
                                        color: AppColors.kWhite,
                                      ),
                                    );
                                  }
                                }
                                return ReorderableDragStartListener(
                                  index: index,
                                  child: const Icon(
                                    Icons.drag_handle_rounded,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: AudioHelper.playlistList.length,
                onReorder: (oldIndex, newIndex) {
                  // logger.i('OldIndex=$oldIndex\nNewIndex=$newIndex',
                  //     error: 'Experimenting reorderable List');
                  int index = newIndex > oldIndex ? newIndex - 1 : newIndex;
                  nowPlayC.reorderQueue(oldIndex, index);
                },
              ),
            ),
            AppSpacing.gapH92,
          ],
        ),
      ),
    );
  }
}
