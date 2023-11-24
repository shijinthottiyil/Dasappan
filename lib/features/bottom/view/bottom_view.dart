import 'dart:ui';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_stream/features/bottom/controller/bottom_controller.dart';
import 'package:music_stream/features/home/view/home_view.dart';
import 'package:music_stream/features/now_play/view/now_play_view.dart';
import 'package:music_stream/features/now_play/view/widgets/play_pause_button.dart';
import 'package:music_stream/features/search/view/search_view.dart';
import 'package:music_stream/features/settings/view/settings_view.dart';
import 'package:music_stream/utils/constants/app_assets.dart';

import 'package:music_stream/utils/constants/app_colors.dart';
import 'package:music_stream/utils/constants/app_typography.dart';
import 'package:music_stream/utils/general_widgets.dart/slide_up_panel/panel.dart';
import 'package:music_stream/utils/helpers/audio_helper.dart';

///PanelController this is used with SlidingUpPanel.
///Here we use this to hide BottomNavigation when the panel is Opened.
final PanelController pc = PanelController();

class BottomView extends StatefulWidget {
  BottomView({super.key});

  @override
  State<BottomView> createState() => _BottomViewState();
}

class _BottomViewState extends State<BottomView> {
  final _controller = Get.put(BottomController());

  final _pages = [const HomeView(), const SearchView(), SettingsView()];

  ///Variable to keep track if the SlidePanel is opend or closed.
  bool isClosed = false;

  ///Expirementing MiniPlayer hiding.
  bool _showMini = true;

  @override
  Widget build(BuildContext context) {
    ///Experimenting animating the visibility of the BottomNavigationBar.
    const duration = Duration(milliseconds: 1000);

    return Scaffold(
      body: Stack(
        children: [
          Obx(
            () => SlidingUpPanel(
              renderPanelSheet: false,
              controller: pc,
              onPanelClosed: () {
                setState(() {
                  if (pc.isPanelClosed) {
                    isClosed = false;
                  }
                });
              },
              onPanelOpened: () {
                setState(() {
                  if (pc.isPanelOpen) {
                    isClosed = true;
                  }
                });
              },
              margin: !isClosed
                  ? EdgeInsets.symmetric(horizontal: 15.w, vertical: 105.w)
                  : null,
              // border: Border.all(color: AppColors.kWhite),
              // borderRadius: !isClosed ? BorderRadius.circular(20).r : null,
              maxHeight: MediaQuery.sizeOf(context).height,
              minHeight: AudioHelper.playlistList.isEmpty ? 0 : 70,
              parallaxEnabled: true,
              body: _pages[_controller.bottom.selectedIndex.value],
              collapsed: GestureDetector(
                onTap: pc.open,
                child: ClipRRect(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      // borderRadius: BorderRadius.circular(15).r,
                      border: Border.all(color: AppColors.kWhite),
                    ),
                    child: AudioHelper.playlistList.isEmpty
                        ? null
                        : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 7.w),
                            child: StreamBuilder(
                              stream: AudioHelper.player.currentIndexStream,
                              builder: (context, currentIndex) {
                                if (currentIndex.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return Obx(
                                  () => Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10).r,
                                        child: FadeInImage(
                                          placeholder: AssetImage(
                                            AppAssets.kLenin,
                                          ),
                                          image: NetworkImage(
                                            AudioHelper.playlistList
                                                .elementAt(currentIndex.data!)
                                                .thumbnail!
                                                .last
                                                .url
                                                .toString(),
                                          ),
                                          imageErrorBuilder:
                                              (context, error, stackTrace) =>
                                                  Image.asset(
                                            AppAssets.kLenin,
                                            width: 60.w,
                                            height: 60.w,
                                            fit: BoxFit.cover,
                                          ),
                                          width: 60.w,
                                          height: 60.w,
                                          fit: BoxFit.cover,
                                          placeholderFit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: 5.w),
                                      Expanded(
                                        child: Text(
                                          AudioHelper.playlistList
                                              .elementAt(currentIndex.data!)
                                              .title
                                              .toString(),
                                          style: AppTypography.kBold12,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: StreamBuilder<PlayerState>(
                                          stream: AudioHelper
                                              .player.playerStateStream,
                                          builder: (_, snapshot) {
                                            final playerState = snapshot.data;
                                            return PlayPauseButton(
                                                playerState: playerState);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                  ),
                ),
              ),
              panel: const NowPlayView(),
            ),
          ),
          AnimatedSlide(
            duration: duration,
            offset: !isClosed ? Offset.zero : const Offset(1, 0),
            child: AnimatedOpacity(
              duration: duration,
              opacity: !isClosed ? 1 : 0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 15, right: 15, bottom: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.kWhite.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(40).r,
                      ),
                      child: Obx(
                        () => GNav(
                          selectedIndex: _controller.bottom.selectedIndex.value,
                          onTabChange: (int index) {
                            // setState(() {
                            //   currentIndex = value;
                            //   // log(currentIndex.toString());
                            // });
                            _controller.changeTab(index);
                          },
                          // backgroundColor: AppColors.kBlue1.withOpacity(0.1),
                          activeColor: AppColors.kWhite,
                          color: AppColors.kGreen,
                          tabBackgroundColor: AppColors.kBlack,
                          padding: const EdgeInsets.all(15),
                          iconSize: 24,
                          gap: 8,
                          tabs: const [
                            GButton(
                              icon: Icons.home_rounded,
                              iconSize: 25,
                              iconColor: AppColors.kBlack,
                              text: "Home",
                            ),
                            GButton(
                              icon: Icons.search_rounded,
                              iconSize: 25,
                              iconColor: AppColors.kBlack,
                              text: "Search",
                            ),
                            GButton(
                              icon: Icons.settings_rounded,
                              iconSize: 25,
                              iconColor: AppColors.kBlack,
                              text: "Settings",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: Obx(
      //   () => NavigationBar(
      //     onDestinationSelected: (int index) {
      //       _controller.changeTab(index);
      //     },
      //     selectedIndex: _controller.bottom.selectedIndex.value,
      //     destinations: const [
      //       NavigationDestination(
      //         icon: Icon(Icons.home),
      //         label: 'Home',
      //       ),
      //       NavigationDestination(
      //         icon: Icon(CupertinoIcons.play_circle_fill),
      //         label: 'Listen Now',
      //       ),
      //       NavigationDestination(
      //         icon: Icon(CupertinoIcons.search),
      //         label: 'Search',
      //       ),
      //     ],
      //   ),
      // ),

      ///Old For BottomNavigationBar used at the time of CurvedAnimatedBottom Navigation Bar.
      // bottomNavigationBar: isClosed
      //     ? null
      //     : Obx(
      //         () => CurvedNavigationBar(
      //           backgroundColor: Colors.transparent,
      //           items: const [
      //             Icon(
      //               Icons.home_rounded,
      //               color: AppColors.kBlack,
      //               size: 25,
      //             ),
      //             // Icon(
      //             //   Icons.play_circle_fill_rounded,
      //             //   color: AppColors.kBlack,
      //             //   size: 25,
      //             // ),
      //             Icon(
      //               Icons.search_rounded,
      //               color: AppColors.kBlack,
      //               size: 25,
      //             ),
      //             Icon(
      //               Icons.settings_rounded,
      //               color: AppColors.kBlack,
      //               size: 25,
      //             ),
      //           ],
      //           onTap: (int index) {
      //             _controller.changeTab(index);
      //           },
      //           index: _controller.bottom.selectedIndex.value,
      //         ),
      //       ),
    );
  }
}
