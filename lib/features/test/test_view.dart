// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:icons_plus/icons_plus.dart';
// import 'package:music_stream/utils/constants/constants.dart';

// class TestView extends StatelessWidget {
//   const TestView({super.key});
//   TabBar get _tabBar => TabBar(
//         indicator: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           color: const Color(0xff1a73e8),
//         ),
//         labelColor: Colors.white,
//         unselectedLabelColor: Colors.black,
//         tabs: const [
//           Tab(icon: Icon(EvaIcons.search)),
//           Tab(icon: Icon(BoxIcons.bxs_playlist)),
//         ],
//       );

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           bottom: PreferredSize(
//             preferredSize: _tabBar.preferredSize,
//             child: Padding(
//               padding: EdgeInsets.symmetric(horizontal: 15.w),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade200,
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: _tabBar,
//               ),
//             ),
//           ),
//           title: Text(
//             'Search',
//             style: AppTypography.kBold24,
//           ),
//         ),
//         body: const TabBarView(
//           children: [
//             SingleChildScrollView(
//               child: Column(
//                 children: [
//                   Text('abc'),
//                   Text('abc'),
//                   Text('abc'),
//                   Text('abc'),
//                   Text('abc'),
//                   Text('abc'),
//                 ],
//               ),
//             ),
//             Icon(Icons.directions_transit),
//           ],
//         ),
//       ),
//     );
//   }
// }
