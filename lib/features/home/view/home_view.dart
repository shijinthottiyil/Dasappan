import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/favorites/controller.dart/favorite_controller.dart';
import 'package:music_stream/features/home/controller/home_controller.dart';
import 'package:music_stream/features/playlist/view/playlist_view.dart';
import 'package:music_stream/features/search/view/search_view.dart';
import 'package:music_stream/utils/logic/helpers/audio_helper.dart';
import 'package:music_stream/utils/ui/constants/constants.dart';
import 'package:music_stream/utils/ui/shared_widgets/shared_widgets.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(HomeController());
    final favoriteC = Get.put(FavoriteController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          GestureDetector(
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: const SearchView(),
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.search_rounded),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await c.getQuickpicks();
        },
        color: AppColors.kBlack,
        backgroundColor: AppColors.kWhite,
        strokeWidth: 4.0,
        child: Padding(
          padding: AppSpacing.gapPSH16,
          child: Scrollbar(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Implementing Favourites
                  /*
                  Container(
                    alignment: Alignment.center,
                    color: Colors.red,
                    width: double.infinity,
                    height: 60.h,
                    child: Text('Favourites'),
                  ),
                  // -----------------------------------------------------------------------------------------------
                  AppSpacing.gapH4,
                  */
                  for (int i = 0; i < c.home.homeList.length; i++) ...[
                    if (i == 0) ...[
                      Text(
                        c.home.homeList[i].title ?? AppTexts.kLoading,
                        style: context.textTheme.titleMedium,
                        // style: AppTypography.kSecondary,
                      ),
                    ],
                    if (i != 0) ...[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.r),
                        child: Text(
                          c.home.homeList[i].title ?? AppTexts.kLoading,
                          style: context.textTheme.titleMedium,
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
                              final data = c.home.homeList[0].contents![index];
                              return ListTile(
                                contentPadding: EdgeInsets.zero,
                                leading: ImageLoaderWidget(
                                  imageUrl: data.thumbnails!.last.url!,
                                  width: 48.w,
                                  height: 48.w,
                                  fit: BoxFit.cover,
                                  borderRadius: BorderRadius.circular(6).r,
                                ),
                                /*
                                 ClipRRect(
                                  borderRadius: BorderRadius.circular(6).r,
                                  //       ),
                                  child: FadeInImage(
                                    placeholder: AssetImage(
                                      AppAssets.kMusicLogo,
                                    ),
                                    image: NetworkImage(
                                      data.thumbnails!.last.url!,
                                    ),
                                    imageErrorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
                                      AppAssets.kMusicLogo,
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
                                */
                                title: Text(
                                  data.title ?? AppTexts.kLoading,
                                  style: AppTypography.kSemiBold14,
                                ),
                                subtitle: Text(
                                  data.artists?[0].name ?? AppTexts.kLoading,
                                  style: AppTypography.kRegular13,
                                ),
                                onTap: () {
                                  // c.mockListTileMethod();
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
                              return GestureDetector(
                                  onTap: () {
                                    PersistentNavBarNavigator.pushNewScreen(
                                      context,
                                      screen: PlaylistView(
                                        // playlistImg: data.thumbnails?.last.url,
                                        playlistName: data.title,
                                        playlistId: data.playlistId,
                                      ),
                                    );
                                    /*
                                  Get.to(
                                    () => PlaylistView(
                                      playlistImg: data.thumbnails?.last.url,
                                      playlistName: data.title,
                                      playlistId: data.playlistId,
                                    ),
                                  );
                                  */
                                  },
                                  child: ImageLoaderWidget(
                                    borderRadius: BorderRadius.circular(6).r,
                                    imageUrl: data.thumbnails!.last.url!,
                                    width: 48.w,
                                    height: 48.w,
                                    fit: BoxFit.fill,
                                  )
                                  /* ClipRRect(
                                  borderRadius: BorderRadius.circular(6).r,
                                  //       ),
                                  child: FadeInImage(
                                    placeholder: AssetImage(
                                      AppAssets.kMusicLogo,
                                    ),
                                    image: NetworkImage(
                                      data.thumbnails!.last.url!,
                                    ),
                                    imageErrorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
                                      AppAssets.kMusicLogo,
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
                                */
                                  );
                            },
                          ),
                        ),
                      ),
                    ]
                  ],
                  Obx(
                    () => AudioHelper.playlistList.isNotEmpty
                        ? AppSpacing.gapH100
                        : AppSpacing.gapH40,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
