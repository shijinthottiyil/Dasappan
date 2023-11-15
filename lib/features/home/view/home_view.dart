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
          appBar: AppBar(
            title: Text(
              "DASAPPAN",
              style: TextStyle(
                fontFamily: 'Orbitron',
                fontWeight: FontWeight.bold,
                fontSize: 32,
                letterSpacing: 2,
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: c.getQuickpicks,
            color: AppColors.kBlack,
            backgroundColor: AppColors.kWhite,
            strokeWidth: 4.0,
            child: Padding(
              padding: EdgeInsets.only(left: 17.w, top: 10.h),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quickpicks',
                      style: AppTypography.kSecondary,
                    ),
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
                          physics: BouncingScrollPhysics(),
                          itemCount: c.home.homeList.length,
                          scrollDirection: Axis.horizontal,
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
                                  imageErrorBuilder:
                                      (context, error, stackTrace) =>
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
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
