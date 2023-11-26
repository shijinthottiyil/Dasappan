import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/now_play/controller/now_controller.dart';
import 'package:music_stream/utils/constants/app_assets.dart';
import 'package:music_stream/utils/constants/app_colors.dart';
import 'package:music_stream/utils/constants/app_texts.dart';
import 'package:music_stream/utils/constants/app_typography.dart';
import 'package:music_stream/utils/helpers/audio_helper.dart';
import 'package:music_stream/utils/networking/logger.dart';

class QueueContainer extends StatelessWidget {
  const QueueContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(NowController());
    return ClipRRect(
      // borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          margin: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 10.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.transparent, //
            border: Border.all(color: AppColors.kWhite, width: 0.1),
          ),
          child: Obx(
            () => ReorderableList(
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
                          style: AppTypography.kSecondary.copyWith(
                            // color: AppColors.kBlack,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListTile(
                          onTap: () {
                            // _playlistC.playSelected(index);
                          },
                          contentPadding: EdgeInsets.all(10.r),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: FadeInImage(
                              placeholder: AssetImage(AppAssets.kLenin),
                              image:
                                  NetworkImage(data.thumbnail?.last.url ?? ''),
                              imageErrorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                AppAssets.kLenin,
                                width: 60.w,
                                height: 60.w,
                                fit: BoxFit.cover,
                              ),
                              fit: BoxFit.cover,
                              placeholderFit: BoxFit.cover,
                              width: 60.w,
                              height: 60.w,
                            ),
                          ),
                          title: Text(
                            data.title ?? AppTexts.kTitle,
                            style: AppTypography.kRegular13.copyWith(
                              // color: AppColors.kBlack,
                              overflow: TextOverflow.ellipsis,
                            ),
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
                                      borderRadius: BorderRadius.circular(5).r,
                                    ),
                                    child: Icon(
                                      Icons.play_circle_rounded,
                                      color: AppColors.kBlack,
                                    ),
                                  );
                                }
                              }
                              return ReorderableDragStartListener(
                                index: index,
                                child: const Icon(
                                  Icons.drag_handle_rounded,
                                  color: AppColors.kWhite,
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
                c.reorderQueue(oldIndex, index);
              },
            ),
          ),
        ),
      ),
    );
  }
}
