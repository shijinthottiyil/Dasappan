import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_stream/view/home/home_screen.dart';
import 'package:music_stream/view/search/search_screen.dart';

class TabBarScreen extends StatelessWidget {
  const TabBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Music explode'),
          centerTitle: true,
          bottom: const TabBar(
            dividerColor: Colors.transparent,
            tabs: <Widget>[
              Tab(
                icon: Icon(CupertinoIcons.home),
              ),
              Tab(
                icon: Icon(CupertinoIcons.search),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            HomeScreen(),
            SearchScreen(),
          ],
        ),
      ),
    );
  }
}
