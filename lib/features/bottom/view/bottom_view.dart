import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/bottom/controller/bottom_controller.dart';
import 'package:music_stream/features/home/view/home_view.dart';
import 'package:music_stream/features/now_play/view/now_play_view.dart';
import 'package:music_stream/features/search/view/search_view.dart';

class BottomView extends StatelessWidget {
  BottomView({super.key});
  final _controller = Get.put(BottomController());
  final _pages = [HomeView(), NowPlayView(), SearchView()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _pages[_controller.bottom.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          onDestinationSelected: (int index) {
            _controller.changeTab(index);
          },
          selectedIndex: _controller.bottom.selectedIndex.value,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(CupertinoIcons.play_circle_fill),
              label: 'Listen Now',
            ),
            NavigationDestination(
              icon: Icon(CupertinoIcons.search),
              label: 'Search',
            ),
          ],
        ),
      ),
    );
  }
}
