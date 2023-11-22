import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
              () => GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: c.search.playlistModelList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10.w,
                  crossAxisSpacing: 10.h,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
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
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4).r,
                            child: FadeInImage(
                              placeholder: AssetImage(
                                AppAssets.kLenin,
                              ),
                              image:
                                  NetworkImage(data.thumbnails?.last.url ?? ''),
                              imageErrorBuilder: (context, error, stackTrace) =>
                                  Image.asset(
                                AppAssets.kLenin,
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
                              style: AppTypography.kSecondary
                                  .copyWith(fontSize: 16.sp),
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
            ),
            AppSpacing.gapH250,
          ],
        ),
      ),
    );
  }
}
