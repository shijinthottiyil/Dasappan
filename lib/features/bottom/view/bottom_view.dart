import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/bottom/controller/bottom_controller.dart';
import 'package:music_stream/features/home/view/home_view.dart';
import 'package:music_stream/features/now_play/view/now_play_view.dart';
import 'package:music_stream/features/search/view/search_view.dart';
import 'package:music_stream/features/settings/view/settings_view.dart';
import 'package:music_stream/features/test/test_view.dart';
import 'package:music_stream/utils/constants/app_colors.dart';
import 'package:icons_plus/icons_plus.dart';

class BottomView extends StatelessWidget {
  BottomView({super.key});
  final _controller = Get.put(BottomController());
  final _pages = [HomeView(), NowPlayView(), SearchView()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _pages[_controller.bottom.selectedIndex.value]),
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

      bottomNavigationBar: Obx(
        () => CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          items: const [
            Icon(
              EvaIcons.home,
              color: AppColors.kBlack,
              size: 25,
            ),
            Icon(
              Iconsax.music_play,
              color: AppColors.kBlack,
              size: 25,
            ),
            Icon(
              EvaIcons.search,
              color: AppColors.kBlack,
              size: 25,
            ),
            // Icon(
            //   Iconsax.setting,
            //   color: AppColors.kBlack,
            //   size: 25,
            // ),
          ],
          onTap: (int index) {
            _controller.changeTab(index);
          },
          index: _controller.bottom.selectedIndex.value,
        ),
      ),
    );
  }
}
