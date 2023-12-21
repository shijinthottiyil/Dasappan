import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomModel {
  var selectedIndex = 0.obs;

  //PageController to create a Animating effect while Navigating.
  var pageController = PageController().obs;
}
