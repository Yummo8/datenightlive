import 'package:DNL/common/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:pressable/pressable.dart';

class IconCheckButton extends StatelessWidget {
  final String title;
  final String icon;
  final bool checked;
  final Function onPressed;
  final Color color;

  const IconCheckButton(
      {super.key,
      required this.title,
      required this.icon,
      required this.checked,
      required this.onPressed,
      this.color = ThemeColors.background});

  @override
  Widget build(BuildContext context) {
    onPressedCallback() {
      onPressed();
    }

    return Pressable.opacity(
      onPressed: onPressedCallback,
      child: Container(
          height: 120,
          decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              border:
                  checked ? Border.all(color: ThemeColors.onSecondary) : null),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Column(
            children: [
              checked
                  ? const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.check,
                          color: ThemeColors.onSecondary,
                          size: 16,
                        )
                      ],
                    )
                  : const SizedBox(height: 17),
              Text(title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: ThemeColors.onSecondary, fontSize: 16)),
              const SizedBox(
                height: 12,
              ),
              Image.asset(
                "assets/icons/$icon.png",
                width: 32,
                height: 32,
              )
            ],
          )),
    );
  }
}
