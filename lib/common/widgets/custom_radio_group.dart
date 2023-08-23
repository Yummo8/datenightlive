import 'package:flutter/material.dart';
import 'package:DNL/common/widgets/custom_radio.dart';

class CustomRadioGroup extends StatelessWidget {
  final List<String> options;
  final String? value;
  final Function onChanged;

  const CustomRadioGroup({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: options
          .map((item) =>
              CustomRadio(value: item, groupValue: value, onChange: onChanged))
          .toList(),
    );
  }
}
