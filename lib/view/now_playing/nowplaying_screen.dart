import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
            Container(
              width: double.infinity,
              height: height / 4,
              color: Colors.green,
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
                  Container(
                    width: double.infinity,
                    height: 5,
                    color: Colors.blue,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {},
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
                        onPressed: () {},
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
