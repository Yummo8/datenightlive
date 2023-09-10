// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:DNL/common/widgets/custom_radio_group.dart';

class DrugChoose extends StatefulWidget {
  final String? drug;
  final Function onChange;

  const DrugChoose({
    super.key,
    this.drug,
    required this.onChange,
  });

  @override
  _DrugChooseState createState() => _DrugChooseState();
}

class _DrugChooseState extends State<DrugChoose> {
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
            value: widget.drug, options: options, onChanged: widget.onChange),
      ],
    );
  }
}
