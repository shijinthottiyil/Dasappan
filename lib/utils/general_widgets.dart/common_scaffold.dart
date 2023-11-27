import 'package:flutter/material.dart';
import 'package:music_stream/utils/general_widgets.dart/bg.dart';

class CommonScaffold extends StatelessWidget {
  const CommonScaffold({
    super.key,
    required this.onWillPop,
    required this.appBarTitle,
    required this.body,
  });
  final Future<bool> Function()? onWillPop;
  final String appBarTitle;
  final Widget? body;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Bg(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              appBarTitle,
              style: const TextStyle(
                fontFamily: 'Orbitron',
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 2,
              ),
            ),
          ),
          body: body,
        ),
      ),
    );
  }
}
