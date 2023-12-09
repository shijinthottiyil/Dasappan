import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import 'package:music_stream/features/search/controller/search_controller.dart';
import 'package:music_stream/features/playlist/view/playlist_view.dart';
import 'package:music_stream/utils/constants/constants.dart';

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
            // Text("Search", style: AppTypography.kSemiBold32),
            AppSpacing.gapH12,
            // CupertinoTextField.borderless(
            //   padding: EdgeInsets.all(15.r),
            //   prefix: Padding(
            //     padding: EdgeInsets.only(left: 15.r),
            //     child: const Icon(
            //       EvaIcons.search,
            //       color: AppColors.kBrown75,
            //     ),
            //   ),
            //   placeholder: "Search Song",
            //   placeholderStyle:
            //       AppTypography.kMedium14.copyWith(color: AppColors.kWhite),
            //   style: AppTypography.kRegular13.copyWith(color: AppColors.kWhite),
            //   decoration: BoxDecoration(
            //     color: AppColors.kBrown400,
            //     borderRadius: BorderRadius.circular(8).r,
            //   ),
            //   onSubmitted: (keyword) {
            //     c.getSearch(keyword);
            //   },
            // ),
            // SearchTextField(
            //   placeholder: 'Search Song',
            //   onSubmitted: (keyWord) {
            //     c.getSearch(keyWord);
            //   },
            // ),
            // AppSpacing.gapH12,
            Obx(
              () {
                //   return GridView.builder(
                //   shrinkWrap: true,
                //   physics: const NeverScrollableScrollPhysics(),
                //   itemCount: c.search.playlistModelList.length,
                //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //     mainAxisSpacing: 10.w,
                //     crossAxisSpacing: 10.h,
                //     crossAxisCount: 2,
                //   ),
                //   itemBuilder: (context, index) {
                //     var data = c.search.playlistModelList[index];

                //     return InkWell(
                //       onTap: () {
                //         Get.to(
                //           () => PlaylistView(
                //             playlistImg: data.thumbnails?.last.url,
                //             playlistName: data.title,
                //             playlistId: data.browseId,
                //           ),
                //         );
                //       },
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Expanded(
                //             flex: 7,
                //             child: ClipRRect(
                //               borderRadius: BorderRadius.circular(4).r,
                //               child: FadeInImage(
                //                 placeholder: AssetImage(
                //                   AppAssets.kLenin,
                //                 ),
                //                 image:
                //                     NetworkImage(data.thumbnails?.last.url ?? ''),
                //                 imageErrorBuilder: (context, error, stackTrace) =>
                //                     Image.asset(
                //                   AppAssets.kLenin,
                //                   width: double.infinity,
                //                   fit: BoxFit.cover,
                //                 ),
                //                 width: double.infinity,
                //                 // height: double.infinity,
                //                 fit: BoxFit.cover,
                //                 placeholderFit: BoxFit.cover,
                //               ),
                //             ),
                //           ),
                //           Expanded(
                //             child: Padding(
                //               padding: EdgeInsets.only(top: 5.h),
                //               child: Text(
                //                 data.title ?? AppTexts.kLoading,
                //                 style: AppTypography.kSecondary,
                //                 softWrap: false,
                //                 maxLines: 4,
                //                 overflow: TextOverflow.ellipsis,
                //               ),
                //             ),
                //           )
                //         ],
                //       ),
                //     );
                //   },
                // );

                ///Trying out new PlayList View.
                ///
                return GridView.custom(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverWovenGridDelegate.count(
                    pattern: [
                      WovenGridTile(1),
                      WovenGridTile(
                        5 / 7,
                        crossAxisRatio: 0.9,
                        alignment: AlignmentDirectional.centerEnd,
                      ),
                    ],
                    crossAxisCount: 2,
                    // mainAxisSpacing: 2,
                    // crossAxisSpacing: 2,
                  ),
                  childrenDelegate: SliverChildBuilderDelegate(
                    childCount: c.search.playlistModelList.length,
                    (context, index) {
                      var data = c.search.playlistModelList[index];

                      return InkWell(
                        onTap: () {
                          Get.to(
                            () => PlaylistView(
                              playlistImg: data.thumbnails?.last.url,
                              playlistName: data.title,
                              playlistId: data.browseId,
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 7,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.kBlack.withOpacity(0.4),
                                      spreadRadius: 2,
                                      blurRadius: 3,
                                      blurStyle: BlurStyle.normal,
                                      offset: Offset(0,
                                          2), // Adjust the offset of the shadow
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: FadeInImage(
                                    placeholder: AssetImage(
                                      AppAssets.kLenin,
                                    ),
                                    image: NetworkImage(
                                        data.thumbnails?.last.url ?? ''),
                                    imageErrorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
                                      AppAssets.kLenin,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    placeholderFit: BoxFit.cover,
                                  ),
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
                  ),
                );
              },
            ),
            AppSpacing.gapH250,
          ],
        ),
      ),
    );
  }
}
