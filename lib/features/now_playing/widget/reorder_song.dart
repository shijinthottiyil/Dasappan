import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:music_stream/features/home/controller/home_provider.dart';

class ReorderSong extends ConsumerWidget {
  const ReorderSong({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(homePageProvider);
    return Container(
      child: ReorderableListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            key: Key("$index"),
            tileColor: Colors.red,
          );
        },
        itemCount: provider.playingSongModelList.length,
        onReorder: (oldIndex, newIndex) {},
      ),
    );
  }
}
