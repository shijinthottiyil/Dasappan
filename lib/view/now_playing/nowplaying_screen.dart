import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_stream/controller/search_controller.dart';

class NowPlayingScreen extends ConsumerWidget {
  const NowPlayingScreen(
      {super.key,
      required this.url,
      required this.title,
      required this.artist});
  final String url;
  final String title;
  final String artist;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.sizeOf(context);
    final height = size.height;
    final width = size.width;
    final provider = ref.watch(searchProvider);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                  width: width / 1.5,
                  height: height / 3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(url),
                      fit: BoxFit.fill,
                      filterQuality: FilterQuality.high,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                )
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: height / 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 24,
                      letterSpacing: 0.2,
                    ),
                  ),
                  Text(
                    artist,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 16,
                      letterSpacing: 0.2,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        provider.position.toString().substring(2, 7),
                        style: TextStyle(color: Colors.white),
                      ),
                      Expanded(
                        child: CupertinoSlider(
                          min: const Duration(microseconds: 0)
                              .inSeconds
                              .toDouble(),
                          max: provider.duration.inSeconds.toDouble(),
                          value: provider.position.inSeconds.toDouble(),
                          activeColor: Colors.white,
                          onChanged: ((value) {
                            // setState(() {
                            //   changeToSeconds(value.toInt());
                            //   value = value;
                            // });
                            provider.onChanged(value);
                          }),
                          // activeColor: Colors.white,

                          // inactiveColor: Colors.white.withOpacity(0.3),
                          // thumbColor: Colors.white,
                        ),
                      ),
                      Text(
                        provider.duration.toString().substring(2, 7),
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(CupertinoIcons.shuffle),
                      ),
                      IconButton(
                        onPressed: provider.fastBackward,
                        icon: Icon(CupertinoIcons.backward_fill),
                      ),
                      IconButton(
                        onPressed: provider.playOrPause,
                        icon: Column(
                          children: [
                            if (provider.player.playing) ...[
                              Icon(CupertinoIcons.pause_fill)
                            ] else if (!provider.player.playing) ...[
                              Icon(CupertinoIcons.play_fill)
                            ]
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: provider.fastForward,
                        icon: Icon(CupertinoIcons.forward_fill),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(CupertinoIcons.arrow_down_to_line_alt),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                provider.currentVolume == provider.minVolume
                    ? Icon(CupertinoIcons.volume_off)
                    : Icon(CupertinoIcons.volume_down),
                Expanded(
                  child: CupertinoSlider(
                    min: provider.minVolume,
                    max: provider.maxVolume,
                    value: provider.currentVolume,
                    onChanged: (value) {
                      provider.controlVolume(value);
                    },
                  ),
                ),
                Icon(CupertinoIcons.volume_up),
              ],
            )
          ],
        ),
      )),
    );
  }
}
