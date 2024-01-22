import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/artist/view/arist_view.dart';
import 'package:music_stream/features/search/controller/search_controller.dart';
import 'package:music_stream/utils/logic/helpers/audio_helper.dart';
import 'package:music_stream/utils/ui/constants/constants.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class SearchArtist extends StatelessWidget {
  const SearchArtist({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<SearchCtr>();
    return Scrollbar(
      child: Padding(
        padding: AppSpacing.gapPSH16,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppSpacing.gapH12,
              Obx(
                () => GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: c.search.artistModelList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 20.w,
                    crossAxisSpacing: 0.h,
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) {
                    final artistData = c.search.artistModelList[index];

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: ArtistView(
                                  // imageUrl: artistData.thumbnails!.last.url!,
                                  artistName: artistData.artist!,
                                  artistId: artistData.browseId!,
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.kBrown100,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: CachedNetworkImageProvider(
                                      artistData.thumbnails!.last.url!),
                                ),
                              ),
                            ),
                          ),
                        ),
                        AppSpacing.gapH12,
                        Text(
                          artistData.artist!,
                          style: context.textTheme.titleMedium,
                          softWrap: false,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    );
                  },
                ),
              ),
              Obx(
                () => AudioHelper.playlistList.isNotEmpty
                    ? AppSpacing.gapH92
                    : AppSpacing.gapH20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
