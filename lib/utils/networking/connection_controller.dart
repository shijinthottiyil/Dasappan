import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:music_stream/utils/helpers/audio_helper.dart';

import 'app_popups.dart';

class ConnectionController extends GetxController {
  // 0 = No Internet,1 = WiFi,2 = Mobile Data
  // var connectionType = 0.obs;

  final Connectivity _connectivity = Connectivity();

  late StreamSubscription _connectivityStream;

  Future<void> getConnectivityType() async {
    late ConnectivityResult connectivityResult;
    try {
      connectivityResult = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return _updateState(connectivityResult);
  }

  // lost connection
  Future<void> lostConnection() async {
    AudioHelper.player.stop();
    await Get.dialog(
      WillPopScope(
        onWillPop: () => Future.value(false),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r)),
            backgroundColor: Colors.transparent,
            child: Container(
              width: 400.w,
              height: 400.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: LottieBuilder.asset('assets/lottie/lost_connection.json'),
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  _updateState(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        AppPopups.cancelDialog();
        break;
      case ConnectivityResult.mobile:
        AppPopups.cancelDialog();
        break;
      case ConnectivityResult.none:
        await lostConnection();
        break;
      default:
        AppPopups.errorSnackbar(
            title: "Error", message: "Failed to get connection type");
        break;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getConnectivityType();
    _connectivityStream = _connectivity.onConnectivityChanged.listen((result) {
      _updateState(result);
    });
  }

  // @override
  // void onClose() {
  //   _connectivityStream.cancel();
  //   super.dispose();
  // }

  @override
  void onClose() {
    _connectivityStream.cancel();
    super.onClose();
  }
}
