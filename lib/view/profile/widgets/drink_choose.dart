// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:DNL/common/widgets/custom_radio_group.dart';

class DrinkChoose extends StatefulWidget {
  final String? drink;
  final Function onChange;

  const DrinkChoose({
    super.key,
    this.drink,
    required this.onChange,
  });

  @override
  _DrinkChooseState createState() => _DrinkChooseState();
}

class _DrinkChooseState extends State<DrinkChoose> {
  @override
  Widget build(BuildContext context) {
    final List<String> options = [
      'Yes',
      'Sometimes',
      'No',
      'Prefer not to say',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomRadioGroup(
            value: widget.drink, options: options, onChanged: widget.onChange),
      ],
    );
  }
}
