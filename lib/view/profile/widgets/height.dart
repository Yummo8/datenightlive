// ignore_for_file: library_private_types_in_public_api

import 'package:DNL/common/values/colors.dart';
import 'package:DNL/view/profile/widgets/bodyType_choose.dart';
import 'package:flutter/material.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

class HeightInput extends StatefulWidget {
  final int height;
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

class _HeightInputState extends State<HeightInput> {
  @override
  Widget build(BuildContext context) {
    List<WheelChoice> heightChoices = [];
    for (int i = 60; i < 90; i++) {
      heightChoices.add(
          WheelChoice(value: i, title: '${i ~/ 12}\' ${i % 12}" ($i inch)'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
            height: 230,
            width: 400,
            child: WheelChooser.choices(
              choices: heightChoices,
              startPosition: widget.height - 60,
              magnification: 1.5,
              selectTextStyle:
                  const TextStyle(backgroundColor: ThemeColors.white),
              unSelectTextStyle: TextStyle(color: ThemeColors.gray[2]),
              onChoiceChanged: (value) => widget.onChangeHeight(value),
            )),
        const SizedBox(height: 20),
        BodyTypesChoose(
          bodyType: widget.bodyType,
          onChange: widget.onChangeBodyType,
        )
      ],
    );
  }
}
