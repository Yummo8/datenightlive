// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:DNL/common/values/custom_text_style.dart';

class HomeTownInput extends StatefulWidget {
  final String town;
  final Function onChange;

  const HomeTownInput({
    super.key,
    required this.town,
    required this.onChange,
  });

  @override
  _HomeTownInputState createState() => _HomeTownInputState();
}

class _HomeTownInputState extends State<HomeTownInput>
    with AutomaticKeepAliveClientMixin<HomeTownInput> {
  final TextEditingController _townEditingController = TextEditingController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _townEditingController.text = widget.town;
  }

  @override
  void dispose() {
    _townEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Theme(
          data: ThemeData(
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent),
          child: TextField(
            autofocus: false,
            style: CustomTextStyle.getSubtitleStyle(
                Theme.of(context).colorScheme.onSecondary),
            decoration: InputDecoration(
                hintText: "New York, US",
                fillColor: Theme.of(context).colorScheme.onBackground,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none),
                hintStyle: CustomTextStyle.getSubtitleStyle(
                    Theme.of(context).colorScheme.onSurface),
                isDense: true),
            controller: _townEditingController,
            onChanged: (String town) {
              widget.onChange(town);
            },
          ),
        )
      ],
    );
  }
}
