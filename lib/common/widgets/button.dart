import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final Function onPressed;
  final bool disabled;
  final bool outlined;
  final bool flag;
  final Widget? tail;
  final Color? background;

  const Button(
      {super.key,
      required this.onPressed,
      required this.title,
      this.disabled = false,
      this.outlined = false,
      this.flag = false,
      this.background,
      this.tail});

  @override
  Widget build(BuildContext context) {
    if (outlined == true) {
      final ButtonStyle buttonStyle = OutlinedButton.styleFrom(
        foregroundColor: flag
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary,
        minimumSize: const Size.fromHeight(48),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        side: BorderSide(
          color: flag
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
          width: 1,
          style: BorderStyle.solid,
        ),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        backgroundColor: background,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(48))),
      );
      return OutlinedButton(
        style: buttonStyle,
        onPressed: (!disabled
            ? () {
                onPressed();
              }
            : null),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(title), Container()]),
      );
    } else {
      final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
        backgroundColor: flag
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.secondary,
        foregroundColor: flag
            ? Theme.of(context).colorScheme.secondary
            : Theme.of(context).colorScheme.primary,
        minimumSize: const Size.fromHeight(48),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(48)),
        ),
      );
      return ElevatedButton(
        style: raisedButtonStyle,
        onPressed: (!disabled
            ? () {
                onPressed();
              }
            : null),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(title),
          tail != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: tail,
                )
              : Container()
        ]),
      );
    }
  }
}
