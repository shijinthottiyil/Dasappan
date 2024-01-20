import 'package:flutter/material.dart';
import 'package:music_stream/utils/ui/constants/app_typography.dart';

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
        Text(
          positionData,
          style: AppTypography.kBold12,
        ),
        Text(
          durationData,
          style: AppTypography.kBold12,
        ),
      ],
    );
  }
}
