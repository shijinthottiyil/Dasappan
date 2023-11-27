// // import 'package:flutter/material.dart';
// // import 'package:speech_to_text/speech_recognition_result.dart';
// // import 'package:speech_to_text/speech_to_text.dart';

// // class TestView extends StatefulWidget {
// //   TestView({Key? key}) : super(key: key);

// //   @override
// //   _TestViewState createState() => _TestViewState();
// // }

// // class _TestViewState extends State<TestView> {
// //   SpeechToText _speechToText = SpeechToText();
// //   bool _speechEnabled = false;
// //   String _lastWords = '';

// //   @override
// //   void initState() {
// //     super.initState();
// //     _initSpeech();
// //   }

// //   /// This has to happen only once per app
// //   void _initSpeech() async {
// //     _speechEnabled = await _speechToText.initialize();
// //     setState(() {});
// //   }

// //   /// Each time to start a speech recognition session
// //   void _startListening() async {
// //     await _speechToText.listen(onResult: _onSpeechResult);
// //     setState(() {});
// //   }

// //   /// Manually stop the active speech recognition session
// //   /// Note that there are also timeouts that each platform enforces
// //   /// and the SpeechToText plugin supports setting timeouts on the
// //   /// listen method.
// //   void _stopListening() async {
// //     await _speechToText.stop();
// //     setState(() {});
// //   }

// //   /// This is the callback that the SpeechToText plugin calls when
// //   /// the platform returns recognized words.
// //   void _onSpeechResult(SpeechRecognitionResult result) {
// //     setState(() {
// //       _lastWords = result.recognizedWords;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Speech Demo'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: <Widget>[
// //             Container(
// //               padding: EdgeInsets.all(16),
// //               child: Text(
// //                 'Recognized words:',
// //                 style: TextStyle(fontSize: 20.0),
// //               ),
// //             ),
// //             Expanded(
// //               child: Container(
// //                 padding: EdgeInsets.all(16),
// //                 child: Text(
// //                   // If listening is active show the recognized words
// //                   _speechToText.isListening
// //                       ? '$_lastWords'
// //                       // If listening isn't active but could be tell the user
// //                       // how to start it, otherwise indicate that speech
// //                       // recognition is not yet ready or not supported on
// //                       // the target device
// //                       : _speechEnabled
// //                           ? 'Tap the microphone to start listening...'
// //                           : 'Speech not available',
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //       floatingActionButton: FloatingActionButton(
// //         onPressed:
// //             // If not yet listening for speech start, otherwise stop
// //             _speechToText.isNotListening ? _startListening : _stopListening,
// //         tooltip: 'Listen',
// //         child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
// //       ),
// //     );
// //   }
// // }

// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:music_stream/utils/constants/app_colors.dart';
// import 'package:music_stream/utils/general_widgets.dart/avatar_glow.dart';
// import 'package:music_stream/utils/networking/logger.dart';
// import 'package:speech_to_text/speech_to_text.dart';

// class TestView extends StatelessWidget {
//   const TestView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final c = Get.put(TestController());
//     return Scaffold(
//       body: Center(
//         child: IconButton(
//           onPressed: () {
//             c.onPress();
//           },
//           icon: Icon(Icons.mic),
//         ),
//       ),
//     );
//   }
// }

// class TestController extends GetxController {
//   final speech = SpeechToText();

//   onPress() async {
//     bool isAvilable = await speech.initialize();
//     if (isAvilable) {
//       await Get.dialog(
//         BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//           child: Dialog(
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20.r)),
//             backgroundColor: AppColors.kWhite,
//             child: Container(
//               decoration:
//                   BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
//               width: 300,
//               height: 300,
//               child: Column(
//                 // mainAxisSize: MainAxisSize.min,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   AvatarGlow(
//                     glowRadiusFactor: 0.7,
//                     animate: true,
//                     glowColor: AppColors.kRed,
//                     child: GestureDetector(
//                       onTap: () async {
//                         await speech.listen(
//                           onResult: (result) {
//                             logger.i(result.recognizedWords);
//                           },
//                         );
//                       },
//                       child: Icon(
//                         Icons.mic_rounded,
//                         color: AppColors.kBlack,
//                         size: 75.sp,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     } else {
//       Get.snackbar('error', 'access dEnied');
//     }
//   }
// }
