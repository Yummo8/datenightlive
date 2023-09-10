// ignore_for_file: library_private_types_in_public_api

import 'package:DNL/common/values/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:DNL/common/widgets/custom_radio_group.dart';

class DrinkChoose extends StatefulWidget {
  final String? drink;
  final String? preferDrink;
  final Function onChange;
  final Function onChangePrefer;

  const DrinkChoose({
    super.key,
    required this.drink,
    required this.preferDrink,
    required this.onChange,
    required this.onChangePrefer,
  });

  @override
  _DrinkChooseState createState() => _DrinkChooseState();
}

class _DrinkChooseState extends State<DrinkChoose> {
  final TextEditingController _drinkEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _drinkEditingController.text = widget.preferDrink.toString();
  }

  @override
  void dispose() {
    _drinkEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> options = [
      'Yes',
      'Sometimes',
      'Never',
    ];

    print(widget.drink);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomRadioGroup(
            value: widget.drink, options: options, onChanged: widget.onChange),
        const SizedBox(height: 20),
        (widget.drink != null && widget.drink != "Yes")
            ? const SizedBox(height: 10)
            : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text("Prefered drink?",
                    style: CustomTextStyle.getSpanStyle(
                        Theme.of(context).colorScheme.onSurface)),
                const SizedBox(height: 5),
                Theme(
                  data: ThemeData(
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent),
                  child: TextField(
                    autofocus: false,
                    style: CustomTextStyle.getSubtitleStyle(
                        Theme.of(context).colorScheme.onSecondary),
                    decoration: InputDecoration(
                        hintText: "",
                        fillColor: Theme.of(context).colorScheme.onBackground,
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide.none),
                        hintStyle: CustomTextStyle.getSubtitleStyle(
                            Theme.of(context).colorScheme.onSurface),
                        isDense: true),
                    controller: _drinkEditingController,
                    onChanged: (String perferDrink) {
                      widget.onChangePrefer(perferDrink);
                    },
                  ),
                )
              ])
      ],
    );
  }
}
