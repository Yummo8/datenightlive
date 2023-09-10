// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:DNL/common/widgets/custom_radio_group.dart';

class ReligiousChoose extends StatefulWidget {
  final String? religious;
  final Function onChange;

  const ReligiousChoose({
    super.key,
    this.religious,
    required this.onChange,
  });

  @override
  _ReligiousChooseState createState() => _ReligiousChooseState();
}

class _ReligiousChooseState extends State<ReligiousChoose> {
  @override
  Widget build(BuildContext context) {
    final List<String> religiouses = [
      'Agnostic',
      'Atheist',
      'Gay',
      'Buddist',
      'Christian',
      'Hindu',
      'Jewish',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomRadioGroup(
            value: widget.religious,
            options: religiouses,
            onChanged: widget.onChange),
      ],
    );
  }
}
