// ignore_for_file: must_be_immutable, library_private_types_in_public_api, unused_field, depend_on_referenced_packages

import 'package:DNL/common/utils/calc.dart';
import 'package:flutter/material.dart';
import 'package:DNL/common/values/colors.dart';
import 'package:DNL/common/values/custom_text_style.dart';
import 'package:DNL/common/widgets/datepicker/lib/widget/date_picker_widget.dart';
import 'package:DNL/common/widgets/datepicker/lib/date_picker_theme.dart';
import 'package:intl/intl.dart';

class TextFieldDatePicker extends StatefulWidget {
  DateTime? value;
  Function onChanged;
  TextFieldDatePicker(
      {super.key, required this.value, required this.onChanged});

  @override
  _TextFieldDatePickerState createState() => _TextFieldDatePickerState();
}

class _TextFieldDatePickerState extends State<TextFieldDatePicker> {
  DateTime? _selected;
  int? _year;
  String? _zodiac;
  final DateFormat formatter = DateFormat('MM/dd/yyyy');

  @override
  void initState() {
    super.initState();
    _selected = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    DateTime currentDate = DateTime.now();
    _year = currentDate.year - (_selected?.year ?? 0);
    _zodiac = getZodiacSign(_selected ?? currentDate);

    return Column(
      children: [
        DatePickerWidget(
          pickerTheme: const DateTimePickerTheme(
            backgroundColor: ThemeColors.secondary,
            itemTextStyle: TextStyle(
                decorationStyle: TextDecorationStyle.solid,
                color: ThemeColors.primary,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontFamily: "Inter"),
          ),
          dateFormat: "dd-MMM-yyyy",
          looping: true,
          initialDate: widget.value,
          onChange: ((DateTime date, list) {
            setState(() {
              _selected = date;
              widget.onChanged(date);
              _year = currentDate.year - date.year;
              _zodiac = getZodiacSign(date);
            });
          }),
        ),
        const SizedBox(height: 20),
        Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(4, 0, 4, 0),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ThemeColors.input,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Your age:",
                    textAlign: TextAlign.center,
                    style: CustomTextStyle.getDescStyle(
                        ThemeColors.onSecondary, 16)),
                const SizedBox(height: 5),
                Text(_year.toString(),
                    textAlign: TextAlign.center,
                    style:
                        CustomTextStyle.getTitleStyle(ThemeColors.primary, 44)),
                const SizedBox(height: 5),
                Text("It looks like you are a $_zodiac",
                    textAlign: TextAlign.center,
                    style: CustomTextStyle.getSpanStyle(ThemeColors.label, 14)),
                const SizedBox(height: 5),
                Image.asset(
                  "assets/zodiac/starter_$_zodiac.png",
                  scale: 1,
                ),
              ],
            ))
      ],
    );
  }
}
