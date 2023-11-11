import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/home/controller/home_controller.dart';
import 'package:music_stream/utils/constants/constants.dart';
import 'package:music_stream/utils/general_widgets.dart/bg.dart';

import 'package:music_stream/utils/helpers/exit_app.dart';
import 'package:music_stream/utils/networking/connection_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    final c = Get.put(HomeController());

    // ignore: unused_local_variable
    final connectionCtr = Get.put(ConnectionController());
    return WillPopScope(
      onWillPop: exitApp,
      child: Bg(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(left: 17.w, top: 120.h),
            child: RefreshIndicator(
              onRefresh: c.getQuickpicks,
              color: AppColors.kBlack,
              backgroundColor: AppColors.kWhite,
              strokeWidth: 4.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "ഹലോ BOSS",
                    style: AppTypography.kExtraBold32,
                  ),
                  Expanded(
                      child: Obx(
                    () => ListView.builder(
                      itemCount: c.home.homeList.length,
                      itemBuilder: (context, index) {
                        var data = c.home.homeList[index];
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
                              imageErrorBuilder: (context, error, stackTrace) =>
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
                            data.title ?? "Name",
                            style: AppTypography.kSemiBold14,
                          ),
                          subtitle: Text(
                            data.artists?[0].name ?? "subtitle",
                            style: AppTypography.kRegular13,
                          ),
                          onTap: () {
                            c.listTileTap(index: index, isHome: true);
                          },
                        );
                      },
                    ),
                  ))
                ],
              ),
              // child: CustomScrollView(
              //   slivers: [
              //     SliverAppBar(
              //       pinned: true,
              //       floating: true,
              //       expandedHeight: 120.h,
              //       flexibleSpace: FlexibleSpaceBar(
              //         titlePadding: EdgeInsets.zero,
              //         title: Padding(
              //           padding: EdgeInsets.symmetric(vertical: 5.w),
              //           child: Text(
              //             "ഹലോ BOSS",
              //             style: AppTypography.kExtraBold24,
              //           ),
              //         ),
              //       ),
              //     ),
              //     Obx(
              //       () => SliverList.builder(
              //         itemBuilder: (context, index) {
              //           var data = _controller.home.homeList[index];
              //           return ListTile(
              //             contentPadding: EdgeInsets.zero,
              //             leading: ClipRRect(
              //               borderRadius: BorderRadius.circular(6).r,
              //               // child: data.thumbnails?.last.url != null
              //               //     ? Image.network(
              //               //         data.thumbnails!.last.url!,
              //               //         width: 48.w,
              //               //         height: 48.w,
              //               //         fit: BoxFit.cover,
              //               //       )
              //               //     : Image.asset(
              //               //         AppAssets.kTileLead,
              //               //         width: 48.w,
              //               //         height: 48.w,
              //               //         fit: BoxFit.cover,
              //               //       ),
              //               child: FadeInImage(
              //                 placeholder: AssetImage(
              //                   AppAssets.kLenin,
              //                 ),
              //                 image: NetworkImage(
              //                   data.thumbnails!.last.url!,
              //                 ),
              //                 imageErrorBuilder: (context, error, stackTrace) =>
              //                     Image.asset(
              //                   AppAssets.kLenin,
              //                   width: 48.w,
              //                   height: 48.w,
              //                   fit: BoxFit.cover,
              //                 ),
              //                 width: 48.w,
              //                 height: 48.w,
              //                 fit: BoxFit.cover,
              //                 placeholderFit: BoxFit.cover,
              //               ),
              //             ),
              //             title: Text(
              //               data.title ?? "Name",
              //               style: AppTypography.kSemiBold14,
              //             ),
              //             subtitle: Text(
              //               data.artists?[0].name ?? "subtitle",
              //               style: AppTypography.kRegular13,
              //             ),
              //             onTap: () {
              //               _controller.listTileTap(index: index, isHome: true);
              //             },
              //           );
              //         },
              //         // separatorBuilder: (context, index) {
              //         //   return Divider(
              //         //     color: AppColors.kWhite,
              //         //     thickness: 0.5,
              //         //     indent: 65.w,
              //         //   );
              //         // },
              //         itemCount: _controller.home.homeList.length,
              //       ),
              //     ),
              //   ],
              // ),
            ),
          ),
        ),
      ),
    );
  }
}
