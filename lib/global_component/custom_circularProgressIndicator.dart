// ignore_for_file: unused_import, library_private_types_in_public_api, file_names

import 'package:flutter/material.dart';

import 'package:mien_spa_mobile/theme/constants.dart';

class CustomCircularProgressIndicator extends StatefulWidget {
  final double strokeWidth;
  final Duration duration;
  const CustomCircularProgressIndicator(
      {Key? key, required this.strokeWidth, required this.duration})
      : super(key: key);

  @override
  _CustomCircularProgressIndicatorState createState() =>
      _CustomCircularProgressIndicatorState();
}

class _CustomCircularProgressIndicatorState
    extends State<CustomCircularProgressIndicator>
    with TickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: false);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: widget.strokeWidth,
        value: controller.value,
        color: KPrimaryColor,
      ),
    );
  }
}
