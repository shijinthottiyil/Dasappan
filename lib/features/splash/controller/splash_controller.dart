import 'package:get/get.dart';
import 'package:music_stream/features/bottom/view/bottom_view.dart';
import 'package:music_stream/old%20feature/home/view/home_page.dart';

class SplashController extends GetxController {
  // go Home
  Future<void> goHome() async {
    Future.delayed(Duration(seconds: 5)).then(
      (value) => Get.offAll(
        BottomView(),
      ),
    );
  }

  @override
  void onInit() {
    goHome();
    super.onInit();
  }
}
