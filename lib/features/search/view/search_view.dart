import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/bottom/controller/bottom_controller.dart';
import 'package:music_stream/features/bottom/view/bottom_view.dart';
import 'package:music_stream/features/search/view/search_play.dart';
import 'package:music_stream/features/search/view/search_song.dart';
import 'package:music_stream/features/search/view/widgets/search_textfield.dart';
import 'package:music_stream/features/search/controller/search_controller.dart';
import 'package:music_stream/features/search/view/widgets/search_textfield_widget.dart';
import 'package:music_stream/utils/constants/constants.dart';
import 'package:music_stream/utils/networking/logger.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  TabBar get _tabBar => const TabBar(
        dividerColor: Colors.transparent,
        tabs: [
          Tab(
              icon: Text(
            'Song',
          )),
          Tab(icon: Icon(Icons.queue_music_rounded)),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final c = Get.put(SearchCtr());
    return DefaultTabController(
      length: 2,
      child: WillPopScope(
        onWillPop: () async {
          if (pc.isPanelOpen) {
            pc.close();
          } else {
            Get.find<BottomController>().bottom.selectedIndex.value = 0;
          }

          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Search',
              // style: Theme.of(context).primaryTextTheme.headlineLarge,
            ),
          ),
          body: Column(
            children: [
              //SearchBar.
              SearchTextFieldWidget(
                onSubmitted: (keword) {
                  c.getSearch(keword);
                },
                onTap: c.voiceSearchTap,
              ),
// ---------------------------------
              /* <---Old TextField.
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SearchTextField(
                  onTap: c.voiceSearchTap,
                  placeholder: 'എന്താ വേണ്ടേ? ',
                  onSubmitted: (keyWord) {
                    c.getSearch(keyWord);
                  },
                ),
              ),
              */
              AppSpacing.gapH8,
              TabBar(
                dividerColor: Colors.transparent,
                tabs: [
                  Tab(
                    icon: Text(
                      'Song',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Tab(
                    icon: Text(
                      'Playlist',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ],
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    SearchSong(),
                    SearchPlay(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
