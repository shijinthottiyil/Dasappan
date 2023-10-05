import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TestView extends StatelessWidget {
  const TestView({super.key});
  TabBar get _tabBar => TabBar(
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Color(0xff1a73e8),
        ),
        tabs: [
          Tab(icon: Icon(Icons.call)),
          Tab(icon: Icon(Icons.message)),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: PreferredSize(
            preferredSize: _tabBar.preferredSize,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8)),
                child: _tabBar,
              ),
            ),
          ),
          title: const Text('Search'),
        ),
        body: const TabBarView(
          children: [
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
          ],
        ),
      ),
    );
  }
}
