import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/bottom/controller/bottom_controller.dart';
import 'package:music_stream/features/home/view/home_view.dart';
import 'package:music_stream/features/mini_player/view/mini_player_view.dart';
import 'package:music_stream/features/now_play/view/now_play_view.dart';
import 'package:music_stream/features/search/view/search_view.dart';
import 'package:music_stream/features/settings/view/settings_view.dart';
import 'package:music_stream/utils/general_widgets.dart/slide_up_panel/panel.dart';
import 'package:music_stream/utils/helpers/audio_helper.dart';

///PanelController this is used with SlidingUpPanel.
///Here we use this to hide BottomNavigation when the panel is Opened.
final PanelController pc = PanelController();

//_pages Variables defines the pages that we use withinout application.
final _pages = [const HomeView(), const SearchView(), const SettingsView()];

class BottomView extends StatelessWidget {
  const BottomView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(BottomController());
    return Scaffold(
      body: Obx(
        () => SlidingUpPanel(
          controller: pc,
          maxHeight: MediaQuery.sizeOf(context).height,
          minHeight: AudioHelper.playlistList.isEmpty ? 0 : 70,
          body: PageView.builder(
            itemBuilder: (_, __) {
              return Obx(() => _pages[c.bottom.selectedIndex.value]);
            },
            itemCount: _pages.length,
            controller: c.bottom.pageController.value,
            onPageChanged: (currentPageIndex) {
              c.bottom.selectedIndex.value = currentPageIndex;
            },
          ),
          panel: const NowPlayView(),
          collapsed: const MiniPlayerView(),
        ),
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          onDestinationSelected: (int index) {
            c.changeTab(index);
          },
          selectedIndex: c.bottom.selectedIndex.value,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.search_rounded),
              label: 'Search',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_rounded),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}
