import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_stream/controller/music_controller.dart';
import 'package:music_stream/old%20feature/home/controller/home_provider.dart';
import 'package:music_stream/utils/loader.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    ref.read(homePageProvider).fetchQuickPicks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(homePageProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quick Picks",
          style: TextStyle(
            fontWeight: FontWeight.w200,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              provider.goSearch(context: context);
            },
            icon: Icon(CupertinoIcons.search),
          ),
        ],
      ),
      body: provider.songModelList.isEmpty
          ? Loader()
          : Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: provider.songModelList.length,
                itemBuilder: (context, index) {
                  final data = provider.songModelList.elementAt(index);
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Image.network(
                      data.thumbnails,
                    ),
                    title: Text(
                      data.title,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    subtitle: Text(
                      data.artists,
                      style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(CupertinoIcons.ellipsis_vertical)),
                    onTap: () {
                      // provider.songTap(
                      //     videoId: data.videoId, selectedIndex: index);
                    },
                  );
                },
              ),
            ),
      bottomNavigationBar: Visibility(
        visible: provider.isMiniShown,
        child: ListTile(
          // contentPadding: EdgeInsets.all(5),
          onTap: () {
            provider.getModelSheet(context: context);
          },
          tileColor: Colors.white,
          // leading: provider.index == -1
          //     ? Image.asset("assets/images/default_music.png")
          //     : Image.network(provider.searchModelList
          //         .elementAt(provider.index)
          //         .thumbnails),

          // leading: Image.network(
          //   provider.songModelList
          //       .elementAt(MusicController.player.currentIndex ?? 0)
          //       .thumbnails,
          // ),
          leading: StreamBuilder(
            stream: MusicController.player.currentIndexStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Image.network(
                  provider.playingSongModelList
                      .elementAt(snapshot.data!)
                      .thumbnails,
                );
              }
              return Loader();
            },
          ),
          title: StreamBuilder(
              stream: MusicController.player.currentIndexStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    provider.playingSongModelList
                        .elementAt(snapshot.data!)
                        .title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                  );
                }
                return Container();
              }),
          subtitle: StreamBuilder(
              stream: MusicController.player.currentIndexStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    provider.playingSongModelList
                        .elementAt(snapshot.data!)
                        .artists,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w100,
                    ),
                  );
                }
                return Container();
              }),
          trailing: StreamBuilder(
              stream: MusicController.player.playingStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return IconButton(
                    onPressed: provider.playOrPause,
                    icon: snapshot.data!
                        ? Icon(
                            CupertinoIcons.pause_fill,
                            color: Colors.black,
                          )
                        : Icon(
                            CupertinoIcons.play_fill,
                            color: Colors.black,
                          ),
                  );
                }
                return Container();
              }),
        ),
      ),
    );
  }
}
