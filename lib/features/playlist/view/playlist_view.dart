import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/playlist/controller/playlist_controller.dart';
import 'package:music_stream/features/playlist/view/widgets/mycustom_clipper.dart';

import 'package:music_stream/utils/constants/constants.dart';
import 'package:music_stream/utils/helpers/audio_helper.dart';

class PlaylistView extends StatefulWidget {
  const PlaylistView({
    super.key,
    required this.playlistImg,
    required this.playlistName,
    required this.playlistId,
  });

  ///For getting the corresponding playlistImage.
  final String? playlistImg;

  ///For getting the corresponding playlistName.
  final String? playlistName;

  ///For getting the corresponding playlistBrowseId.
  final String? playlistId;

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  ///Getx Controllers.

  final _playlistC = Get.put(PlaylistController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playlistC.getPlaylistList(widget.playlistId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              ClipPath(
                clipper: MyCustomClipper(),
                child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height / 2.5,
                  child: FadeInImage(
                    placeholder: AssetImage(
                      AppAssets.kLenin,
                    ),
                    image: NetworkImage(
                      widget.playlistImg!,
                    ),
                    imageErrorBuilder: (context, error, stackTrace) =>
                        Image.asset(
                      AppAssets.kLenin,
                      // width: 48.w,
                      // height: 48.w,
                      fit: BoxFit.cover,
                    ),
                    // width: 48.w,
                    // height: 48.w,
                    fit: BoxFit.cover,
                    placeholderFit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemBuilder: (context, index) {
                      var data = _playlistC.playlist.playlistList[index];
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${index + 1}.',
                              // style: AppTypography.kSecondary.copyWith(
                              //   color: AppColors.kBlack,
                              //   overflow: TextOverflow.ellipsis,
                              // ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              onTap: () {
                                _playlistC.playSelected(index);
                              },
                              contentPadding: EdgeInsets.all(10.r),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10.r),
                                child: FadeInImage(
                                  placeholder: AssetImage(AppAssets.kLenin),
                                  image: NetworkImage(
                                      data.thumbnail?.last.url ?? ''),
                                  imageErrorBuilder:
                                      (context, error, stackTrace) =>
                                          Image.asset(
                                    AppAssets.kLenin,
                                    width: 60.w,
                                    height: 60.w,
                                    fit: BoxFit.cover,
                                  ),
                                  fit: BoxFit.cover,
                                  placeholderFit: BoxFit.cover,
                                  width: 60.w,
                                  height: 60.w,
                                ),
                              ),
                              title: Text(
                                data.title ?? 'title',
                                style: AppTypography.kRegular13.copyWith(
                                  // color: AppColors.kBlack,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: _playlistC.playlist.playlistList.length,
                  ),
                ),
              ),
              if (AudioHelper.playlistList.isNotEmpty) ...[
                AppSpacing.gapH100,
              ]
            ],
          ),
          Positioned(
            top: 50.h,
            left: 0,
            right: 0,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    // Get.back();
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(CupertinoIcons.back),
                ),
                Expanded(
                  child: Text(
                    widget.playlistName ?? AppTexts.kLoading,
                    style: AppTypography.kBold24.copyWith(
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
          //Button to play all songs in the playlist in the original order.
          Positioned(
            right: 10,
            top: context.height / 3,
            child: FloatingActionButton(
              onPressed: _playlistC.playAll,
              child: const Icon(Icons.play_arrow_rounded),
            ),
          ),
        ],
      ),
      /*
      floatingActionButton: AnimatedSlide(
        duration: duration,
        offset: _showFab ? Offset.zero : const Offset(0, 2),
        child: AnimatedOpacity(
          duration: duration,
          opacity: _showFab ? 1 : 0,
          child: FloatingActionButton(
            elevation: 10,
            backgroundColor: AppColors.kBlack,
            onPressed: () {
              _playlistC.playAll();
            },
            child: const Icon(Icons.play_arrow_rounded),
          ),
        ),
      ),
    );
    */
    );
  }
}
