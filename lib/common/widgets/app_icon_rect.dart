import 'package:flutter/material.dart';
import 'package:DNL/common/values/colors.dart';

class AppIconRect extends StatelessWidget {
  final double width;
  const AppIconRect({super.key, this.width = 80});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: ThemeColors.background),
        padding: const EdgeInsets.all(14),
        width: width,
        height: width,
        child: Image.asset(
          "assets/images/app_icon.png",
        ));
  }
}
