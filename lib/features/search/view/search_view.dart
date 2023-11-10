import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:music_stream/features/home/controller/home_controller.dart';
import 'package:music_stream/features/playlist/view/playlist_view.dart';
import 'package:music_stream/features/search/view/search_play.dart';
import 'package:music_stream/features/search/view/search_song.dart';
import 'package:music_stream/features/search/view/widgets/search_textfield.dart';
import 'package:music_stream/utils/constants/constants.dart';
import 'package:music_stream/features/search/controller/search_controller.dart';
import 'package:music_stream/utils/helpers/exit_app.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

// class SearchView extends StatelessWidget {
//   SearchView({super.key});
//   final _controller = Get.put(SearchCtr());
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: exitApp,
//       child: Scaffold(
//           body: Padding(
//         padding: EdgeInsets.only(
//           top: 54.h,
//           left: 8.w,
//           right: 8.w,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Search", style: AppTypography.kSemiBold32),
//             AppSpacing.gapH12,
//             CupertinoTextField.borderless(
//               prefix: Padding(
//                 padding: const EdgeInsets.only(left: 10).w,
//                 child: const Icon(
//                   Icons.search,
//                   color: AppColors.kBrown75,
//                 ),
//               ),
//               placeholder: "Enter a song name",
//               placeholderStyle:
//                   AppTypography.kMedium18.copyWith(color: AppColors.kWhite),
//               style: AppTypography.kMedium18.copyWith(color: AppColors.kWhite),
//               decoration: BoxDecoration(
//                 color: AppColors.kBrown400,
//                 borderRadius: BorderRadius.circular(15).r,
//               ),
//               onSubmitted: (keyword) {
//                 _controller.getSearch(keyword);
//               },
//             ),
//             Obx(
//               () => Expanded(
//                 child: ListView.builder(
//                   itemBuilder: (context, index) {
//                     var data = _controller.search.searchList[index];
//                     return ListTile(
//                       contentPadding: EdgeInsets.zero,
//                       leading: ClipRRect(
//                         borderRadius: BorderRadius.circular(6).r,
//                         child: FadeInImage(
//                           placeholder: AssetImage(
//                             AppAssets.kTileLead,
//                           ),
//                           image: NetworkImage(
//                             data.thumbnails!.last.url!,
//                           ),
//                           width: 48.w,
//                           height: 48.w,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       title: Text(
//                         data.title ?? "Name",
//                         style: AppTypography.kSemiBold14,
//                       ),
//                       subtitle: Text(
//                         data.artists?[0].name ?? "subtitle",
//                         style: AppTypography.kRegular13,
//                       ),
//                       onTap: () {
//                         Get.find<HomeController>()
//                             .listTileTap(index: index, isHome: false);
//                       },
//                     );
//                   },
//                   itemCount: _controller.search.searchList.length,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       )),
//     );
//   }
// }

class SearchView extends StatelessWidget {
  const SearchView({super.key});
  TabBar get _tabBar => TabBar(
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xff1a73e8),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.black,
        tabs: [
          Tab(icon: Icon(EvaIcons.search)),
          Tab(icon: Icon(BoxIcons.bxs_playlist)),
        ],
      );

  @override
  Widget build(BuildContext context) {
    var c = Get.put(SearchCtr());
    return DefaultTabController(
      length: 2,
      child: WillPopScope(
        onWillPop: exitApp,
        child: Scaffold(
          appBar: AppBar(
            titleSpacing: 14.r,
            bottom: PreferredSize(
              preferredSize: _tabBar.preferredSize,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _tabBar,
                ),
              ),
            ),
            title: SearchTextField(
              placeholder: 'Search Song or Playlist',
              onSubmitted: (keyWord) {
                c.getSearch(keyWord);
              },
            ),
          ),
          body: TabBarView(
            children: [
              SearchSong(),
              SearchPlay(),
            ],
          ),
        ),
      ),
    );
  }
}
