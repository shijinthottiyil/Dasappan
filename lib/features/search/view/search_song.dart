import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/home/controller/home_controller.dart';
import 'package:music_stream/features/search/controller/search_controller.dart';
import 'package:music_stream/utils/logic/helpers/audio_helper.dart';
import 'package:music_stream/utils/ui/constants/constants.dart';
import 'package:music_stream/utils/ui/shared_widgets/shared_widgets.dart';

class SearchSong extends StatelessWidget {
  const SearchSong({super.key});

  @override
  Widget build(BuildContext context) {
    var c = Get.put(SearchCtr());
    return Scrollbar(
      child: Padding(
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
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var data = c.search.searchList[index];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: ImageLoaderWidget(
                        imageUrl: data.thumbnails!.last.url!,
                        width: 48.w,
                        height: 48.w,
                        fit: BoxFit.cover,
                        borderRadius: BorderRadius.circular(6).r,
                      ),
                      title: Text(
                        data.title ?? "Name",
                        style: AppTypography.kSemiBold14,
                      ),
                      subtitle: Text(
                        data.artists?[0].name ?? "subtitle",
                        style: AppTypography.kRegular13,
                      ),
                      onTap: () {
                        Get.find<HomeController>()
                            .listTileTap(index: index, isHome: false);
                      },
                    );
                  },
                  itemCount: c.search.searchList.length,
                ),
              ),
              Obx(
                () => AudioHelper.playlistList.isNotEmpty
                    ? AppSpacing.gapH80
                    : AppSpacing.gapH20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
