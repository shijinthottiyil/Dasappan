import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/playlist/controller/playlist_controller.dart';
import 'package:music_stream/features/playlist/service/playlist_service.dart';
import 'package:music_stream/features/search/controller/search_controller.dart';
import 'package:music_stream/utils/constants/constants.dart';

class PlaylistView extends StatefulWidget {
  PlaylistView({
    super.key,
    required this.playlistImg,
    required this.playlistName,
    required this.playlistId,
  });

  ///For getting the corresponding playlistImage.
  String? playlistImg;

  ///For getting the corresponding playlistName.
  String? playlistName;

  ///For getting the corresponding playlistBrowseId.
  String? playlistId;

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
    // final c = Get.put()
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(
              sigmaX: 5,
              sigmaY: 5,
            ),
            child: Image.network(
              widget.playlistImg ?? '',
              fit: BoxFit.fill,
            ),
          ),
          Scaffold(
            appBar: AppBar(
              title: Text(widget.playlistName ?? ''),
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(CupertinoIcons.back),
              ),
            ),
            backgroundColor: Colors.transparent,
            body: Obx(
              () => ListView.builder(
                itemBuilder: (context, index) {
                  var data = _playlistC.playlist.playlistList[index];
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('${index + 1}.'),
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
                              placeholder: AssetImage(AppAssets.kLogo),
                              image:
                                  NetworkImage(data.thumbnail?.last.url ?? ''),
                              imageErrorBuilder: (context, error, stackTrace) =>
                                  Icon(Icons.error),
                              fit: BoxFit.cover,
                              width: 60.w,
                              height: 60.w,
                            ),
                          ),
                          title: Text(
                            data.title ?? 'title',
                            style: TextStyle(overflow: TextOverflow.ellipsis),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                itemCount: _playlistC.playlist.playlistList.length,
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                _playlistC.playAll();
              },
              label: Text('Play All'),
              icon: Icon(Icons.play_arrow_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
