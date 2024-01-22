import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:music_stream/features/search/view/search_artist.dart';
import 'package:music_stream/features/search/view/search_play.dart';
import 'package:music_stream/features/search/view/search_song.dart';
import 'package:music_stream/features/search/controller/search_controller.dart';
import 'package:music_stream/features/search/view/widgets/search_textfield_widget.dart';
import 'package:music_stream/utils/ui/constants/constants.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  /*<-----Used when the TabBar has Icon.
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
*/
  @override
  Widget build(BuildContext context) {
    final c = Get.put(SearchCtr());
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          // title: const Text(
          //   'Search',
          //   // style: Theme.of(context).primaryTextTheme.headlineLarge,
          // ),
          title: SearchTextFieldWidget(
            onSubmitted: (keword) {
              c.getSearch(keword);
            },
            onTap: c.voiceSearchTap,
          ),
          leading: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              // Get.back();
              Navigator.of(context).pop();
            },
            icon: const Icon(CupertinoIcons.back),
          ),
        ),
        body: Column(
          children: [
            //SearchBar.
            // SearchTextFieldWidget(
            //   onSubmitted: (keword) {
            //     c.getSearch(keword);
            //   },
            //   onTap: c.voiceSearchTap,
            // ),
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
                    'Songs',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Tab(
                  icon: Text(
                    'Playlists',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Tab(
                  icon: Text(
                    'Artists',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  SearchSong(),
                  SearchPlay(),
                  SearchArtist(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
