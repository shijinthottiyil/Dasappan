/*<---------Old Code Which consists of Image of Playlist in Custom Shape--------------------->
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/home/model/playlist_model.dart';
import 'package:music_stream/features/playlist/controller/playlist_controller.dart';
import 'package:music_stream/features/playlist/view/widgets/mycustom_clipper.dart';
import 'package:music_stream/utils/logic/helpers/audio_helper.dart';
import 'package:music_stream/utils/ui/constants/constants.dart';
import 'package:music_stream/utils/ui/shared_widgets/shared_widgets.dart';

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
  // --------------------------------------.
  // List to store playlistData.RxList<PlaylistModel>.
  final _playlistList = List<PlaylistModel>.empty(growable: true).obs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _playlistC.getPlaylistList(widget.playlistId);
      _fetchData();
    });
  }

//Method to fetch information about the user selected playlist.
  Future<void> _fetchData() async {
    _playlistList.value = await _playlistC.getPlaylistList(widget.playlistId);
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
                  child: ImageLoaderWidget(
                    imageUrl: widget.playlistImg!,
                    width: double.maxFinite,
                    height: double.maxFinite,
                    fit: BoxFit.cover,
                  ),
                  /* FadeInImage(
                    placeholder: AssetImage(
                      AppAssets.kMusicLogo,
                    ),
                    image: NetworkImage(
                      widget.playlistImg!,
                    ),
                    imageErrorBuilder: (context, error, stackTrace) =>
                        Image.asset(
                      AppAssets.kMusicLogo,
                      // width: 48.w,
                      // height: 48.w,
                      fit: BoxFit.cover,
                    ),
                    // width: 48.w,
                    // height: 48.w,
                    fit: BoxFit.cover,
                    placeholderFit: BoxFit.cover,
                  ),
                  */
                ),
              ),
              Expanded(
                  child: FutureBuilder(
                future: _playlistC.getPlaylistList(widget.playlistId),
                builder: (BuildContext context,
                    AsyncSnapshot<List<PlaylistModel>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        var data = snapshot.data?[index];
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
                                leading: ImageLoaderWidget(
                                  borderRadius: BorderRadius.circular(10.r),
                                  imageUrl: data!.thumbnail!.last.url!,
                                  width: 60.w,
                                  height: 60.w,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(
                                  data.title ?? 'title',
                                  style: context.textTheme.labelLarge,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      itemCount: _playlistC.playlist.playlistList.length,
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('Has Error'),
                    );
                  }
                  return Center(
                    child: Text(
                      'Loading',
                      style: AppTypography.kBold12,
                    ),
                  );
                },
              )
                  /*ListView.builder(
                  itemBuilder: (context, index) {
                    var data = _playlistList[index];
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
                                placeholder: AssetImage(AppAssets.kMusicLogo),
                                image: NetworkImage(
                                    data.thumbnail?.last.url ?? ''),
                                imageErrorBuilder:
                                    (context, error, stackTrace) => Image.asset(
                                  AppAssets.kMusicLogo,
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
                */
                  ),
              Obx(() {
                if (AudioHelper.playlistList.isNotEmpty) {
                  return AppSpacing.gapH100;
                } else {
                  return Container();
                }
              }),
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
            top: context.height / 2.8,
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
*/
//----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//New Version of Playlist View Which is as minimal as possible.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/home/model/playlist_model.dart';
import 'package:music_stream/features/playlist/controller/playlist_controller.dart';
import 'package:music_stream/utils/logic/helpers/audio_helper.dart';
import 'package:music_stream/utils/ui/constants/constants.dart';
import 'package:music_stream/utils/ui/shared_widgets/shared_widgets.dart';

class PlaylistView extends StatefulWidget {
  const PlaylistView({
    super.key,
    required this.playlistId,
    required this.playlistName,
  });

  ///Name of the corresponding playlist.
  final String? playlistName;

  ///BrowseId of the corresponding playlist.
  final String? playlistId;

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  var playlistList = <PlaylistModel>[].obs;

  ///Getx Controllers.
  final playlistC = Get.put(PlaylistController());
  // --------------------------------------.

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // playlistC.getPlaylistList(widget.playlistId);
      getPlaylistList();
    });
  }

  Future<void> getPlaylistList() async {
    playlistList.value = await playlistC.getPlaylistList(widget.playlistId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            // Get.back();
            Navigator.of(context).pop();
          },
          icon: const Icon(CupertinoIcons.back),
        ),
        titleSpacing: 0,
        title: Text(
          widget.playlistName!,
          style: context.textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: playlistC.playAll,
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: ShapeDecoration(
                // color: AppColors.kRed,
                shape: StadiumBorder(
                  side: BorderSide(color: context.theme.iconTheme.color!),
                ),
              ),
              child: Text(
                'Play',
                style: context.textTheme.titleMedium,
              ),
              // width: 30,
              // height: 20,
            ),
          )
        ],
      ),
      body: Scrollbar(
        child: Padding(
          padding: AppSpacing.gapPSH16,
          child: Column(
            children: [
              Expanded(
                  child: Obx(
                () => ListView.builder(
                  itemBuilder: (context, index) {
                    final songData = playlistList[index];
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '${index + 1}.',
                            style: context.textTheme.labelLarge,
                            // style: AppTypography.kSecondary.copyWith(
                            //   color: AppColors.kBlack,
                            //   overflow: TextOverflow.ellipsis,
                            // ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            onTap: () {
                              playlistC.playSelected(index);
                            },
                            contentPadding: EdgeInsets.all(10.r),
                            leading: ImageLoaderWidget(
                              borderRadius: BorderRadius.circular(10.r),
                              imageUrl: songData.thumbnail!.last.url!,
                              width: 60.w,
                              height: 60.w,
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              songData.title ?? 'title',
                              style: context.textTheme.titleMedium,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  itemCount: playlistList.length,
                ),
              )),
              Obx(() {
                if (AudioHelper.playlistList.isNotEmpty) {
                  return AppSpacing.gapH100;
                } else {
                  return Container();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
