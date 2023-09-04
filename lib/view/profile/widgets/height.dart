// ignore_for_file: library_private_types_in_public_api

import 'package:DNL/view/profile/widgets/bodyType_choose.dart';
import 'package:flutter/material.dart';
import 'package:DNL/common/values/custom_text_style.dart';

class HeightInput extends StatefulWidget {
  final String height;
  final String bodyType;
  final Function onChangeHeight;
  final Function onChangeBodyType;

  const HeightInput({
    super.key,
    required this.height,
    required this.bodyType,
    required this.onChangeHeight,
    required this.onChangeBodyType,
  });

  @override
  _HeightInputState createState() => _HeightInputState();
}

class _HeightInputState extends State<HeightInput>
    with AutomaticKeepAliveClientMixin<HeightInput> {
  final TextEditingController _heightEditingController =
      TextEditingController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _heightEditingController.text = widget.height;
  }

  @override
  void dispose() {
    _heightEditingController.dispose();
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
                hintText: "Your height (cm)",
                fillColor: Theme.of(context).colorScheme.onBackground,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none),
                hintStyle: CustomTextStyle.getSubtitleStyle(
                    Theme.of(context).colorScheme.onSurface),
                isDense: true),
            controller: _heightEditingController,
            onChanged: (String height) {
              widget.onChangeHeight(height);
            },
          ),
        ),
        const SizedBox(height: 40),
        BodyTypesChoose(
          bodyType: widget.bodyType,
          onChange: widget.onChangeBodyType,
        )
      ],
    );
  }
}
