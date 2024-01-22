import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/favorites/view/favorite_view.dart';
import 'package:music_stream/features/home/view/home_view.dart';
import 'package:music_stream/features/mini_player/view/mini_player_view.dart';
import 'package:music_stream/features/now_play/view/now_play_view.dart';
import 'package:music_stream/features/settings/view/settings_view.dart';
import 'package:music_stream/utils/logic/helpers/audio_helper.dart';
import 'package:music_stream/utils/logic/helpers/exit_app.dart';
import 'package:music_stream/utils/ui/shared_widgets/slide_up_panel/panel.dart';

// Expirementing Persistent BottomNavigationBar in Flutter
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

///PanelController this is used with SlidingUpPanel.
///Here we use this to hide BottomNavigation when the panel is Opened.
final PanelController pc = PanelController();

//_pages Variables defines the pages that we use withinout application.
final _pages = [
  const HomeView(),
  // const SearchView(),
  const FavoriteView(),
  const SettingsView()
];

/*final _items = [
    PersistentBottomNavBarItem(
      icon: Icon(Icons.home_rounded),
      title: 'Home',
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.search_rounded),
      title: 'Search',
    ),
    PersistentBottomNavBarItem(
      icon: Icon(Icons.settings_rounded),
      title: 'Settings',
    ),
  ];
  */

// //PersistentTabController.
// late PersistentTabController _controller;

class BottomView extends StatelessWidget {
  const BottomView({super.key});

  @override
  Widget build(BuildContext context) {
    // _controller = PersistentTabController(initialIndex: 0);
    return Obx(
      () => PopScope(
        canPop: false,
        onPopInvoked: (bool didPop) {
          exitApp();
        },
        child: SlidingUpPanel(
          renderPanelSheet: true,
          margin: const EdgeInsets.only(bottom: 70),
          controller: pc,
          maxHeight: MediaQuery.sizeOf(context).height,
          minHeight: AudioHelper.playlistList.isEmpty ? 0 : 70,
          panel: const Material(child: NowPlayView()),
          collapsed: const Material(child: MiniPlayerView()),
          body: Material(
            child: PersistentTabView(
              context,
              onItemSelected: (int selectedItem) {
                // print(selectedItem);

                pc.close();
              },
              backgroundColor: context.isDarkMode
                  ? context.theme.colorScheme.secondary
                  : context.theme.primaryColor,

              // controller: _controller,
              screens: _pages,
              items: [
                PersistentBottomNavBarItem(
                  activeColorPrimary: _getActiveColorPrimary(context),
                  icon: const Icon(Icons.home_rounded),
                  title: 'Home',
                ),
                // PersistentBottomNavBarItem(
                //   activeColorPrimary: _getActiveColorPrimary(context),
                //   icon: const Icon(Icons.search_rounded),
                //   title: 'Search',
                // ),
                PersistentBottomNavBarItem(
                  activeColorPrimary: _getActiveColorPrimary(context),
                  icon: const Icon(Icons.favorite_rounded),
                  title: 'Favorite',
                ),
                PersistentBottomNavBarItem(
                  activeColorPrimary: _getActiveColorPrimary(context),
                  icon: const Icon(Icons.settings_rounded),
                  title: 'Settings',
                ),
              ],
              navBarStyle: NavBarStyle.style13,
              navBarHeight: 70,
            ),
          ),
        ),
      ),
    );
  }

//Helper Method of Changing the BottomNavigationBar Icon Based on Device Theme.
  Color _getActiveColorPrimary(BuildContext context) {
    // return context.isDarkMode ? AppColors.kBlack : AppColors.kBlack;
    return context.theme.iconTheme.color!;
  }
  // ---------------------------------------------------------------------
}











/*
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
*/