// ignore_for_file: must_be_immutable, library_private_types_in_public_api, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:DNL/common/values/colors.dart';
import 'package:DNL/common/values/custom_text_style.dart';
import 'package:DNL/common/widgets/button.dart';
import 'package:DNL/core/blocs/info/info_bloc.dart';
import 'package:DNL/core/models/info_model.dart';

class PromptAnswerPage extends StatefulWidget {
  String prompt;
  String answer;
  int index;

  PromptAnswerPage(
      {super.key,
      required this.prompt,
      required this.answer,
      required this.index});

  static Route<void> route(
          {required prompt, required answer, required index}) =>
      MaterialPageRoute<void>(
          builder: (_) =>
              PromptAnswerPage(prompt: prompt, answer: answer, index: index));

  @override
  _PromptAnswerPageState createState() => _PromptAnswerPageState();
}

class _PromptAnswerPageState extends State<PromptAnswerPage> {
  final TextEditingController _controller = TextEditingController();
  bool _isValid = true;
  List<String>? prompts;
  List<String>? answers;

  void changeAnswer() {
    bool validResult = true;
    if (answers![widget.index] != null) {
      validResult = false;
    }
    if (answers![widget.index] == "") {
      validResult = true;
    }

    setState(() {
      _isValid = validResult;
    });
  }

  @override
  void initState() {
    super.initState();

    _controller.text = widget.answer;

    InfoModel info = context.read<InfoBloc>().state.info;
    if (info.prompts == null) {
      prompts = ["", "", ""];
    } else {
      prompts = info.prompts;
    }
    if (info.answers == null) {
      answers = ["", "", ""];
    } else {
      answers = info.answers;
    }

    prompts![widget.index] = widget.prompt;
    answers![widget.index] = widget.answer;
    context.read<InfoBloc>().add(InfoUpdated(info.copyWith(prompts: prompts)));

    if (answers![widget.index] != null && answers![widget.index] != "") {
      setState(() {
        _isValid = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.secondary,
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
                      "assets/icons/answer.svg",
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 12),
                    Text('Write an answer',
                        style: CustomTextStyle.getTitleStyle()),
                    const SizedBox(height: 12),
                    Text(widget.prompt,
                        textAlign: TextAlign.center,
                        style: CustomTextStyle.getTitleStyle(
                            Theme.of(context).colorScheme.onSecondary,
                            20,
                            FontWeight.w500)),
                    const SizedBox(height: 24),
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary,
                          border: Border.all(
                              color: Theme.of(context).colorScheme.outline),
                          borderRadius: BorderRadius.circular(15.0)),
                      padding: const EdgeInsets.all(12),
                      child: TextField(
                        maxLength: 100,
                        maxLines: 5,
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: "Write your answer here",
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                        ),
                        style: const TextStyle(
                            color: ThemeColors.onSecondary, fontSize: 15),
                        onChanged: (answer) {
                          answers![widget.index] = answer;
                          InfoModel info = context.read<InfoBloc>().state.info;
                          context.read<InfoBloc>().add(
                              InfoUpdated(info.copyWith(answers: answers)));
                          changeAnswer();
                        },
                      ),
                    ),
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
                  Expanded(
                      child: Button(
                          title: "NEXT",
                          disabled: _isValid,
                          flag: true,
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          })),
                  const SizedBox(width: 8),
                ]),
                const SizedBox(height: 16),
              ],
            )));
  }
}
