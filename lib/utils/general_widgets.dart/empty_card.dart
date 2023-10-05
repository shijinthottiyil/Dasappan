import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyCard extends StatelessWidget {
  const EmptyCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LottieBuilder.asset('assets/lottie/empty.json'),
    );
  }
}
