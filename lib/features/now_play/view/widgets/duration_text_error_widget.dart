import 'package:flutter/material.dart';

class DurationTextErrorWidget extends StatelessWidget {
  const DurationTextErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('0:0'),
        Text('1:0'),
      ],
    );
  }
}
