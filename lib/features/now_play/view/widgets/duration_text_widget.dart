import 'package:flutter/material.dart';

class DurationTextWidget extends StatelessWidget {
  const DurationTextWidget(
      {super.key, required this.positionData, required this.durationData});

  final String positionData;
  final String durationData;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(positionData),
        Text(durationData),
      ],
    );
  }
}
