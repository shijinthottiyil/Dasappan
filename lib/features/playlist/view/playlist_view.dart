import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/playlist/controller/playlist_controller.dart';

import 'package:music_stream/utils/constants/constants.dart';

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

  ///Expirementing FAB hiding.
  bool _showFab = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _playlistC.getPlaylistList(widget.playlistId);
    });
  }

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 300);
    // final c = Get.put()
    return Stack(
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
              icon: const Icon(CupertinoIcons.back),
            ),
          ),
          backgroundColor: Colors.transparent,
          body: NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              final ScrollDirection direction = notification.direction;
              setState(() {
                if (direction == ScrollDirection.reverse) {
                  _showFab = false;
                } else if (direction == ScrollDirection.forward) {
                  _showFab = true;
                }
              });
              return true;
            },
            child: Obx(
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
                              placeholder: AssetImage(AppAssets.kLenin),
                              image:
                                  NetworkImage(data.thumbnail?.last.url ?? ''),
                              imageErrorBuilder: (context, error, stackTrace) =>
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
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis),
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
        ),
      ],
    );
  }
}
