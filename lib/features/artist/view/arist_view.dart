import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/artist/controller/artist_controller.dart';
import 'package:music_stream/utils/logic/helpers/audio_helper.dart';
import 'package:music_stream/utils/ui/constants/constants.dart';
import 'package:music_stream/utils/ui/shared_widgets/shared_widgets.dart';

class ArtistView extends StatefulWidget {
  const ArtistView({
    super.key,
    required this.artistName,
    required this.artistId,
  });

  ///Artist Name.
  final String artistName;

  ///ArtistId.
  final String artistId;

  @override
  State<ArtistView> createState() => _ArtistViewState();
}

class _ArtistViewState extends State<ArtistView> {
  ///Getx Controllers.
  final _artistC = Get.put(ArtistController());
  // --------------------------------------.

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _playlistC.getPlaylistList(widget.playlistId);
      _fetchData();
    });
  }

//Method to fetch information about the user selected Artist.
  Future<void> _fetchData() async {
    await _artistC.getArtistSongs(widget.artistId);
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
          widget.artistName,
          style: context.textTheme.headlineSmall!.copyWith(
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              AudioHelper.playAll(_artistC.artist.artistList);
            },
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
              Obx(
                () => Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final artistData = _artistC.artist.artistList[index];
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${index + 1}.',
                              style: context.textTheme.labelLarge,
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              onTap: () {
                                AudioHelper.playSelected(
                                    index, _artistC.artist.artistList);
                              },
                              contentPadding: EdgeInsets.all(10.r),
                              leading: ImageLoaderWidget(
                                borderRadius: BorderRadius.circular(10.r),
                                imageUrl: artistData.thumbnail!.last.url!,
                                width: 60.w,
                                height: 60.w,
                                fit: BoxFit.cover,
                              ),
                              title: Text(
                                artistData.title ?? 'title',
                                style: context.textTheme.titleMedium,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    itemCount: _artistC.artist.artistList.length,
                  ),
                ),
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
        ),
      ),
    );
  }
}
