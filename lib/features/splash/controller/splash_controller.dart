import 'package:get/get.dart';
import 'package:music_stream/features/bottom/view/bottom_view.dart';

class SplashController extends GetxController {
  // go Home
  Future<void> goHome() async {
    ///---------------------OLD VERSION-------------------------------
    // Future.delayed(Duration(seconds: 5)).then(
    //   (value) => Get.offAll(
    //     BottomView(),
    //   ),
    // );

    Get.offAll(BottomView());
  }

  // @override
  // void onInit() {
  //   goHome();
  //   super.onInit();
  // }
}
