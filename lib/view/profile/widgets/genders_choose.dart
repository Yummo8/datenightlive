// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:DNL/common/widgets/custom_radio_group.dart';

List<String> genders = [
  'Man',
  'Woman',
  'Other',
];

class GendersChoose extends StatefulWidget {
  final String? gender;
  final Function onChange;

  const GendersChoose({
    super.key,
    this.gender,
    required this.onChange,
  });

  @override
  _GendersChooseState createState() => _GendersChooseState();
}

class _GendersChooseState extends State<GendersChoose> {
  String option = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomRadioGroup(
            value: widget.gender, options: genders, onChanged: widget.onChange),
      ],
    );
  }
}
