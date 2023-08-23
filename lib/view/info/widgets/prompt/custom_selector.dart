import 'package:flutter/material.dart';
import './custom_select_element.dart';

class CustomSelector extends StatelessWidget {
  final List<String> prompts;
  final String answer;
  final int index;

  const CustomSelector(
      {super.key,
      required this.prompts,
      required this.answer,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: prompts
          .map((item) =>
              CustomSelectElement(prompt: item, answer: answer, index: index))
          .toList(),
    );
  }
}
