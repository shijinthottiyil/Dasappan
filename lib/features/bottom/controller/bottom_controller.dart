import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_stream/features/bottom/model/bottom_model.dart';
import 'package:music_stream/features/bottom/view/bottom_view.dart';

class BottomController extends GetxController {
  // Variables
  var bottom = BottomModel();

  // change tabs
  void changeTab(int index) {
    pc.close();
    bottom.selectedIndex.value = index;
    // bottom.pageController.value.animateToPage(
    //   bottom.selectedIndex.value,
    //   duration: const Duration(milliseconds: 200),
    //   curve: Curves.easeIn,
    // );
  }
}
