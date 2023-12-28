import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/bottom/view/bottom_view.dart';
import 'package:music_stream/features/home/controller/home_controller.dart';
import 'package:music_stream/features/playlist/view/playlist_view.dart';
import 'package:music_stream/utils/constants/constants.dart';
import 'package:music_stream/utils/general_widgets.dart/common_scaffold.dart';
import 'package:music_stream/utils/helpers/audio_helper.dart';
import 'package:music_stream/utils/helpers/exit_app.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(HomeController());

    return CommonScaffold(
      onWillPop: () async {
        if (pc.isPanelOpen) {
          pc.close();
        } else {
          await exitApp();
        }
        return false;
      },
      appBarTitle: AppTexts.kTitleEng,
      body: RefreshIndicator(
        onRefresh: () async {
          await c.getQuickpicks();
        },
        color: AppColors.kBlack,
        backgroundColor: AppColors.kWhite,
        strokeWidth: 4.0,
        child: Padding(
          padding: EdgeInsets.only(left: 17.w, top: 10.h, right: 17.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (int i = 0; i < c.home.homeList.length; i++) ...[
                  if (i == 0) ...[
                    Text(
                      c.home.homeList[i].title ?? AppTexts.kLoading,
                      // style: AppTypography.kSecondary,
                    ),
                  ],
                  if (i != 0) ...[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 20.r),
                      child: Text(
                        c.home.homeList[i].title ?? AppTexts.kLoading,
                        // style: AppTypography.kSecondary,
                      ),
                    ),
                  ],
                  if (i == 0) ...[
                    Obx(
                      () => SizedBox(
                        height: 400,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 5.w,
                            crossAxisCount: 5,
                            mainAxisExtent: 325.w,
                          ),
                          physics: const BouncingScrollPhysics(),
                          itemCount: c.home.homeList[0].contents?.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            var data = c.home.homeList[0].contents![index];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(6).r,
                                //       ),
                                child: FadeInImage(
                                  placeholder: AssetImage(
                                    AppAssets.kLenin,
                                  ),
                                  image: NetworkImage(
                                    data.thumbnails!.last.url!,
                                  ),
                                  imageErrorBuilder:
                                      (context, error, stackTrace) =>
                                          Image.asset(
                                    AppAssets.kLenin,
                                    width: 48.w,
                                    height: 48.w,
                                    fit: BoxFit.cover,
                                  ),
                                  width: 48.w,
                                  height: 48.w,
                                  fit: BoxFit.cover,
                                  placeholderFit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                data.title ?? AppTexts.kLoading,
                                style: AppTypography.kSemiBold14,
                              ),
                              subtitle: Text(
                                data.artists?[0].name ?? AppTexts.kLoading,
                                style: AppTypography.kRegular13,
                              ),
                              onTap: () {
                                c.listTileTap(index: index, isHome: true);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ] else ...[
                    Obx(
                      () => SizedBox(
                        height: 400,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.5,
                            mainAxisSpacing: 25.h,
                            crossAxisSpacing: 25.h,
                            crossAxisCount: 2,
                            mainAxisExtent: 200.w,
                          ),
                          physics: const BouncingScrollPhysics(),
                          itemCount: c.home.homeList[i].contents?.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            var data = c.home.homeList[i].contents![index];
                            return InkWell(
                              onTap: () {
                                Get.to(
                                  () => PlaylistView(
                                    playlistImg: data.thumbnails?.last.url,
                                    playlistName: data.title,
                                    playlistId: data.playlistId,
                                  ),
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6).r,
                                //       ),
                                child: FadeInImage(
                                  placeholder: AssetImage(
                                    AppAssets.kLenin,
                                  ),
                                  image: NetworkImage(
                                    data.thumbnails!.last.url!,
                                  ),
                                  imageErrorBuilder:
                                      (context, error, stackTrace) =>
                                          Image.asset(
                                    AppAssets.kLenin,
                                    // width: 48.w,
                                    // height: 48.w,
                                    fit: BoxFit.cover,
                                  ),
                                  // width: 48.w,
                                  // height: 48.w,
                                  fit: BoxFit.fill,
                                  placeholderFit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ]
                ],
                Obx(
                  () => AudioHelper.playlistList.isNotEmpty
                      ? AppSpacing.gapH200
                      : AppSpacing.gapH125,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
