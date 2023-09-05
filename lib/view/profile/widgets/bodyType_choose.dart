// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:DNL/common/widgets/custom_radio_group.dart';

List<String> types = [
  'Petite',
  'Curvy',
  'Athletic',
  'Average',
  'Prefer not to say',
];

class BodyTypesChoose extends StatefulWidget {
  final String? bodyType;
  final Function onChange;

  const BodyTypesChoose({
    super.key,
    this.bodyType,
    required this.onChange,
  });

  @override
  _BodyTypesChooseState createState() => _BodyTypesChooseState();
}

class _BodyTypesChooseState extends State<BodyTypesChoose> {
  String option = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomRadioGroup(
            value: widget.bodyType, options: types, onChanged: widget.onChange),
      ],
    );
  }
}
