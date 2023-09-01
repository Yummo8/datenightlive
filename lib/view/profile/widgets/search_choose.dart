// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:DNL/common/widgets/custom_radio_group.dart';

List<String> searchs = [
  'Just for fun',
  'Short term relationship',
  'Long term relationship',
  'Marrige',
];

class SearchChoose extends StatefulWidget {
  final String? search;
  final Function onChange;

  const SearchChoose({
    super.key,
    this.search,
    required this.onChange,
  });

  @override
  _SearchChooseState createState() => _SearchChooseState();
}

class _SearchChooseState extends State<SearchChoose> {
  String option = "";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomRadioGroup(
            value: widget.search, options: searchs, onChanged: widget.onChange),
      ],
    );
  }
}
