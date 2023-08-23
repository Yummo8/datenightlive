// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:DNL/common/values/custom_text_style.dart';
import 'package:DNL/common/widgets/button.dart';
import './custom_selector.dart';

List<String> prompts = [
  "I feel most supported when",
  "My cry-in-the-car song is",
  "Therapy recently taught me",
  "When I need advice, I go to",
  "I hype myself up by",
  "My friends ask me for advice about",
  "My self-care routine is",
  "My happy place is",
  "To me,relaxation is",
];

class PromptSelectPage extends StatelessWidget {
  final String prompt;
  final String answer;
  final int index;

  const PromptSelectPage(
      {super.key,
      required this.prompt,
      required this.answer,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        resizeToAvoidBottomInset: false,
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: Column(
                  children: [
                    const SizedBox(height: 48),
                    SvgPicture.asset(
                      "assets/icons/selfcare.svg",
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 12),
                    Text('Select a prompt',
                        style: CustomTextStyle.getTitleStyle()),
                    const SizedBox(height: 24),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                            decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0))),
                            child: CustomSelector(
                                prompts: prompts,
                                answer: answer,
                                index: index)),
                      ),
                    )
                  ],
                )),
                Row(children: <Widget>[
                  const SizedBox(width: 8),
                  Expanded(
                      child: Button(
                          title: "BACK",
                          flag: true,
                          outlined: true,
                          onPressed: () {
                            Navigator.of(context).pop();
                          })),
                  const SizedBox(width: 8),
                ]),
                const SizedBox(height: 16),
              ],
            )));
  }
}
