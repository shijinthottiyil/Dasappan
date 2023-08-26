import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_stream/controller/search_controller.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.sizeOf(context).height;
    final provider = ref.watch(searchProvider);
    // provider.getSearch("kaavala");
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: height / 20,
              ),
              Text(
                "Search",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Inter',
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(width: double.infinity, height: height / 90),
              CupertinoTextField(
                controller: provider.searchController,
                onSubmitted: (value) {
                  provider.getSearch(value.trim().toLowerCase());
                },
              ),
              if (provider.isLoading) ...[
                Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
              if (provider.searchModelList != 0) ...[
                Expanded(
                  child: GridView.builder(
                    itemCount: provider.searchModelList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 1,
                    ),
                    itemBuilder: (context, index) {
                      final data = provider.searchModelList.elementAt(index);
                      return Card(
                        color: Colors.transparent,
                        child: Expanded(
                          child: Column(
                            children: [
                              Image.network(data.thumbnails),
                              Text(data.title,
                                  style: TextStyle(
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis)),
                              Text(data.artists,
                                  style: TextStyle(
                                      color: Colors.white,
                                      overflow: TextOverflow.ellipsis)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
