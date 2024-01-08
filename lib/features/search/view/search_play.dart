import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/search/controller/search_controller.dart';
import 'package:music_stream/features/playlist/view/playlist_view.dart';
import 'package:music_stream/utils/constants/constants.dart';
import 'package:music_stream/utils/helpers/audio_helper.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class SearchPlay extends StatelessWidget {
  const SearchPlay({super.key});

  @override
  Widget build(BuildContext context) {
    var c = Get.put(SearchCtr());
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSpacing.gapH12,
            Obx(
              () {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: c.search.playlistModelList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 15.w,
                    crossAxisSpacing: 10.h,
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    var data = c.search.playlistModelList[index];

                    return InkWell(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: PlaylistView(
                            playlistImg: data.thumbnails?.last.url,
                            playlistName: data.title,
                            playlistId: data.browseId,
                          ),
                        );
                        /*
                        Get.to(
                          () => PlaylistView(
                            playlistImg: data.thumbnails?.last.url,
                            playlistName: data.title,
                            playlistId: data.browseId,
                          ),
                        );
                        */
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 7,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(4).r,
                              child: FadeInImage(
                                placeholder: AssetImage(
                                  AppAssets.kMusicLogo,
                                ),
                                image: NetworkImage(
                                    data.thumbnails?.last.url ?? ''),
                                imageErrorBuilder:
                                    (context, error, stackTrace) => Image.asset(
                                  AppAssets.kMusicLogo,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                width: double.infinity,
                                // height: double.infinity,
                                fit: BoxFit.cover,
                                placeholderFit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: 5.h),
                              child: Text(
                                data.title ?? AppTexts.kLoading,
                                style: AppTypography.kSecondary,
                                softWrap: false,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
            ),
            Obx(
              () => AudioHelper.playlistList.isNotEmpty
                  ? AppSpacing.gapH92
                  : AppSpacing.gapH20,
            ),
          ],
        ),
      ),
    );
  }
}
