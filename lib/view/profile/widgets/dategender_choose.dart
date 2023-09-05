// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:DNL/common/widgets/custom_radio_group.dart';

List<String> dateGenders = [
  'Male',
  'Female',
  'Both',
];

class DateGenderChoose extends StatefulWidget {
  final String? dateGender;
  final Function onChange;

  const DateGenderChoose({
    super.key,
    this.dateGender,
    required this.onChange,
  });

  @override
  _DateGenderChooseState createState() => _DateGenderChooseState();
}

class _DateGenderChooseState extends State<DateGenderChoose> {
  String option = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomRadioGroup(
            value: widget.dateGender,
            options: dateGenders,
            onChanged: widget.onChange),
      ],
    );
  }
}
