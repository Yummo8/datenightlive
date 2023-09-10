// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:DNL/common/values/colors.dart';
import 'package:DNL/common/values/custom_text_style.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DistanceSlider extends StatelessWidget {
  final String unit;
  final double value;
  final Function onChangedValue;
  final Function onChangedUnit;

  DistanceSlider(
      {super.key,
      required this.unit,
      required this.value,
      required this.onChangedValue,
      required this.onChangedUnit});

  @override
  Widget build(BuildContext context) {
    List<String> units = ["km", "mi"];

    return Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(4, 0, 4, 0),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ThemeColors.input,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                const Text("Search radius",
                    style: TextStyle(
                        color: ThemeColors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                const Spacer(
                  flex: 1,
                ),
                Text(value.round().toString(),
                    style: CustomTextStyle.getSubtitleStyle(ThemeColors.black)),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    hint: Text(
                      'km',
                      style:
                          CustomTextStyle.getSubtitleStyle(ThemeColors.gray[4]),
                    ),
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                    ),
                    iconSize: 24,
                    iconEnabledColor: ThemeColors.black,
                    iconDisabledColor: ThemeColors.gray[1],
                    items: units
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: CustomTextStyle.getSubtitleStyle(
                                    ThemeColors.black),
                              ),
                            ))
                        .toList(),
                    value: unit,
                    onChanged: (value) {
                      onChangedUnit(value);
                    },
                    buttonHeight: 56,
                    isDense: true,
                    buttonPadding: const EdgeInsets.all(0),
                    itemHeight: 56,
                  ),
                )
              ]),
              Slider(
                value: value,
                max: 100,
                onChanged: (double v) {
                  onChangedValue(v);
                },
              )
            ]));
  }
}
