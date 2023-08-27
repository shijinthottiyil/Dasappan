import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_stream/controller/search_controller.dart';

class NowPlayingScreen extends ConsumerWidget {
  const NowPlayingScreen({super.key, required this.url, required this.title});
  final String url;
  final String title;
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
                      fit: BoxFit.cover,
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
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      letterSpacing: 0.2,
                    ),
                  ),
                  Column(
                    children: [
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(trackHeight: 2),
                        child: Slider(
                          min: const Duration(microseconds: 0)
                              .inSeconds
                              .toDouble(),
                          max: provider.duration.inSeconds.toDouble(),
                          value: provider.position.inSeconds.toDouble(),
                          onChanged: ((value) {
                            // setState(() {
                            //   changeToSeconds(value.toInt());
                            //   value = value;
                            // });
                            provider.onChanged(value);
                          }),
                          activeColor: Colors.white,
                          inactiveColor: Colors.white.withOpacity(0.3),
                          thumbColor: Colors.white,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(23, 0, 23, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              provider.position.toString().substring(2, 7),
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              provider.duration.toString().substring(2, 7),
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: provider.fastBackward,
                        icon: Icon(Icons.fast_rewind_rounded),
                      ),
                      IconButton(
                        onPressed: provider.playOrPause,
                        icon: Column(
                          children: [
                            if (provider.player.playing) ...[
                              Icon(Icons.pause_rounded)
                            ] else if (!provider.player.playing) ...[
                              Icon(Icons.play_arrow_rounded)
                            ]
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: provider.fastForward,
                        icon: Icon(Icons.fast_forward_rounded),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 5,
                  color: Colors.blue,
                )
              ],
            )
          ],
        ),
      )),
    );
  }
}
