// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import './prompt_anwer_page.dart';
import 'package:pressable/pressable.dart';

class CustomSelectElement extends StatefulWidget {
  final String prompt;
  final String answer;
  final int index;

  const CustomSelectElement(
      {super.key,
      required this.prompt,
      required this.answer,
      required this.index});

  @override
  _CustomSelectElementState createState() => _CustomSelectElementState();
}

class _CustomSelectElementState extends State<CustomSelectElement> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Pressable.opacity(
          onPressed: () {
            Navigator.of(context).push(PromptAnswerPage.route(
                prompt: widget.prompt,
                answer: widget.answer,
                index: widget.index));
          },
          child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        widget.prompt,
                        style: TextStyle(
                          color: Color(0xFF212325),
                          fontSize: 20,
                          fontFamily: 'Manrope',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.40,
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
