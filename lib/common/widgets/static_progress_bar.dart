import 'package:flutter/material.dart';

class StaticProgressBar extends StatelessWidget {
  final int count;
  final int current;

  const StaticProgressBar(
      {super.key, required this.count, required this.current});

  @override
  Widget build(BuildContext context) {
    final progress = <Widget>[];
    for (var i = 1; i <= count; i++) {
      progress.add(Expanded(
          child: Container(
        margin: const EdgeInsets.fromLTRB(0, 12, 0, 12),
        height: 4.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: current >= i
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(4),
        ),
      )));
      if (i < count) progress.add(const SizedBox(width: 7));
    }
    return Row(children: progress);
  }
}
