// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:DNL/common/widgets/custom_radio_group.dart';

List<String> list = [
  'Single',
  'In relationship',
  'Married',
  'Complicated',
];

class RelStatus extends StatefulWidget {
  final String? relStatus;
  final Function onChange;

  const RelStatus({
    super.key,
    this.relStatus,
    required this.onChange,
  });

  @override
  _RelStatusState createState() => _RelStatusState();
}

class _RelStatusState extends State<RelStatus> {
  String option = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomRadioGroup(
            value: widget.relStatus, options: list, onChanged: widget.onChange),
      ],
    );
  }
}
