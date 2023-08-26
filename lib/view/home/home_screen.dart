import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:music_stream/controller/home_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(homeProvider);
    provider.mock();
    final progresProvider = ref.watch(downloadProgressProvider);
    log(progresProvider.toDouble().toString());
    final height = MediaQuery.sizeOf(context).height;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              width: double.infinity,
              height: height / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.shade300,
                boxShadow: [
                  // Bottom Right Shadow Darker
                  BoxShadow(
                    color: Colors.grey.shade500,
                    // Negative value of offset means top left corner (-1,-1) means top left corner
                    // (1,1) Means Bottom Right Corner
                    offset: const Offset(5, 5),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                  // Top Left Shadow Lighter
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-5, -5),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                      "Youtube Video to mp3 converter",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 0.5,
                      ),
                    ),
                    CupertinoTextField(
                      controller: provider.textController,
                      placeholder: "Paste video link",
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    Visibility(
                      visible: !provider.isLoading,
                      replacement: LoadingAnimationWidget.halfTriangleDot(
                        color: Colors.black,
                        size: 25,
                      ),
                      child: Column(
                        children: [
                          if (progresProvider == 0 ||
                              progresProvider == 100) ...[
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    // Bottom Right Darker
                                    BoxShadow(
                                      color: Colors.grey.shade500,
                                      offset: const Offset(5, 5),
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                    ),
                                    // Top Left
                                    const BoxShadow(
                                      color: Colors.white,
                                      offset: Offset(-5, -5),
                                      blurRadius: 5,
                                      spreadRadius: 1,
                                    ),
                                  ]),
                              child: IconButton(
                                color: Colors.black,
                                onPressed: () {
                                  ref.read(homeProvider).covert(context, ref);
                                },
                                icon: const Icon(Icons.download),
                              ),
                            ),
                          ] else ...[
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                CircularProgressIndicator(
                                  value: progresProvider / 100,
                                  backgroundColor: Colors.grey,
                                  strokeWidth: 6,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Colors.black),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "$progresProvider%",
                                    style: const TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ]
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
