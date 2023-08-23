// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:DNL/common/widgets/text_field_date_picker.dart';

class BirthdayChoose extends StatefulWidget {
  final DateTime birthday;
  final Function onChange;

  const BirthdayChoose(
      {super.key, required this.birthday, required this.onChange});

  @override
  _BirthdayChooseState createState() => _BirthdayChooseState();
}

class _BirthdayChooseState extends State<BirthdayChoose> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
      child: TextFieldDatePicker(
        value: widget.birthday,
        onChanged: (value) {
          setState(() {
            widget.onChange(value);
          });
        },
      ),
    );
  }
}
