import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/home/controller/home_controller.dart';
import 'package:music_stream/utils/constants/constants.dart';
import 'package:music_stream/features/search/controller/search_controller.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});
  final _controller = Get.put(SearchCtr());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(
        top: 54.h,
        left: 8.w,
        right: 8.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Search", style: AppTypography.kSemiBold32),
          AppSpacing.gapH12,
          CupertinoTextField.borderless(
            prefix: Padding(
              padding: EdgeInsets.only(left: 10).w,
              child: Icon(
                Icons.search,
                color: AppColors.kBrown75,
              ),
            ),
            placeholder: "Enter a song name",
            placeholderStyle:
                AppTypography.kMedium18.copyWith(color: AppColors.kWhite),
            style: AppTypography.kMedium18.copyWith(color: AppColors.kWhite),
            decoration: BoxDecoration(
              color: AppColors.kBrown400,
              borderRadius: BorderRadius.circular(15).r,
            ),
            onSubmitted: (keyword) {
              _controller.getSearch(keyword);
            },
          ),
          Obx(
            () => Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  var data = _controller.search.searchList[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(6).r,
                      child: FadeInImage(
                        placeholder: AssetImage(
                          AppAssets.kTileLead,
                        ),
                        image: NetworkImage(
                          data.thumbnails!.last.url!,
                        ),
                        width: 48.w,
                        height: 48.w,
                        fit: BoxFit.cover,
                      ),
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
                itemCount: _controller.search.searchList.length,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
