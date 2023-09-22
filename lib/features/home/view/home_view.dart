import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/home/controller/home_controller.dart';
import 'package:music_stream/utils/constants/constants.dart';
import 'package:music_stream/utils/networking/app_popups.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final _controller = Get.put(HomeController());

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17.w),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              floating: true,
              expandedHeight: 120.h,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.zero,
                title: Text(
                  "Listen Now",
                  style: AppTypography.kExtraBold24,
                ),
              ),
            ),
            Obx(
              () => SliverList.separated(
                itemBuilder: (context, index) {
                  var data = _controller.home.homeList[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(6).r,
                      child: data.thumbnails?[1].url != null
                          ? Image.network(
                              data.thumbnails![1].url!,
                              width: 48.w,
                              height: 48.w,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              AppAssets.kTileLead,
                              width: 48.w,
                              height: 48.w,
                              fit: BoxFit.cover,
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
                      _controller.play(index: index);
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    color: AppColors.kWhite,
                    thickness: 0.5,
                    indent: 65.w,
                  );
                },
                itemCount: _controller.home.homeList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}