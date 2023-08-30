import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:music_stream/controller/search_controller.dart';
import 'package:music_stream/utils/loader.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.sizeOf(context).height;
    final provider = ref.watch(searchProvider);
    // provider.getSearch("kaavala");
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: CupertinoTextField(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          placeholder: "Enter a name",
          placeholderStyle: TextStyle(
            color: Colors.black.withOpacity(0.4),
            fontWeight: FontWeight.w300,
          ),
          prefix: Padding(
            padding: const EdgeInsets.only(left: 7),
            child: Icon(CupertinoIcons.search, color: Colors.black),
          ),
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
          controller: provider.searchController,
          onSubmitted: (value) {
            provider.getSearch(value.trim().toLowerCase());
          },
        ),
      ),
      body: provider.isLoading
          ? const Loader()
          : SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(
                    //   width: double.infinity,
                    //   height: height / 20,
                    // ),
                    // Text(
                    //   "Search",
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontFamily: 'Inter',
                    //     fontSize: 32,
                    //     fontWeight: FontWeight.w600,
                    //   ),
                    // ),
                    // SizedBox(width: double.infinity, height: height / 90),
                    // CupertinoTextField(
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     borderRadius: BorderRadius.circular(6),
                    //   ),
                    //   placeholder: "Enter a name",
                    //   placeholderStyle: TextStyle(
                    //     color: Colors.black.withOpacity(0.4),
                    //     fontWeight: FontWeight.w300,
                    //   ),
                    //   prefix: Padding(
                    //     padding: const EdgeInsets.only(left: 7),
                    //     child: Icon(CupertinoIcons.search, color: Colors.black),
                    //   ),
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.w500,
                    //   ),
                    //   controller: provider.searchController,
                    //   onSubmitted: (value) {
                    //     provider.getSearch(value.trim().toLowerCase());
                    //   },
                    // ),
                    if (provider.searchModelList.isEmpty) ...[
                      Expanded(
                        child: Center(
                          child: Lottie.asset(
                            "assets/images/search_i.json",
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                    if (provider.searchModelList.isNotEmpty) ...[
                      Expanded(
                        child: GridView.builder(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          itemCount: provider.searchModelList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 5,
                          ),
                          itemBuilder: (context, index) {
                            final data =
                                provider.searchModelList.elementAt(index);
                            return InkWell(
                              // <========================== IMPLEMENTATION BEFORE SHOWMODAL BOTTOM SHEET ===============================>
                              // onTap: () {
                              //   ref.read(searchProvider).goNowPlay(
                              //         context,
                              //         url: data.thumbnails,
                              //         title: data.title,
                              //         index: index,
                              //       );
                              // },
                              // <==========================================================================================================>
                              onTap: () {
                                provider.searchCardTap(selectedIndex: index);
                              },
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: height / 6.4,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                        image: NetworkImage(data.thumbnails),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  // Image.network(
                                  //   data.thumbnails,
                                  //   fit: BoxFit.cover,
                                  // ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.title,
                                        style: TextStyle(
                                            color: Colors.white,
                                            overflow: TextOverflow.ellipsis,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Text(
                                        data.artists,
                                        style: TextStyle(
                                          color: Colors.white,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w100,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Visibility(
                        visible: true,
                        child: ListTile(
                          // contentPadding: EdgeInsets.all(5),
                          onTap: () {
                            provider.listTileTap(context: context);
                          },
                          tileColor: Colors.white,
                          leading: provider.index == -1
                              ? Image.asset("assets/images/default_music.png")
                              : Image.network(provider.searchModelList
                                  .elementAt(provider.index)
                                  .thumbnails),

                          title: Text(
                            provider.title,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          subtitle: Text(
                            provider.subTitle,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: provider.playOrPause,
                            icon: provider.player.playing
                                ? Icon(
                                    CupertinoIcons.pause_fill,
                                    color: Colors.black,
                                  )
                                : Icon(
                                    CupertinoIcons.play_fill,
                                    color: Colors.black,
                                  ),
                          ),
                        ),
                      ),
                    ],

                    // Container(
                    //   width: double.infinity,
                    //   height: 40,
                    //   color: Colors.red,
                    // ),
                  ],
                ),
              ),
            ),
    );
  }
}
