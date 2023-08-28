// ignore_for_file: unnecessary_new, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:DNL/core/blocs/info/info_bloc.dart';
import 'package:DNL/core/models/info_model.dart';
import 'package:pressable/pressable.dart';
import 'package:DNL/common/values/custom_text_style.dart';
import './prompt_select_page.dart';

class PromptInput extends StatefulWidget {
  final List<String> prompts;
  final List<String> answers;

  const PromptInput({
    super.key,
    required this.prompts,
    required this.answers,
  });

  @override
  _PromptInputState createState() => _PromptInputState();
}

class _PromptInputState extends State<PromptInput>
    with AutomaticKeepAliveClientMixin<PromptInput> {
  @override
  bool get wantKeepAlive => true;

  void popPrompt(index) {
    InfoModel info = context.read<InfoBloc>().state.info;
    info.answers![index] = "";
    info.prompts![index] = "";
    context
        .read<InfoBloc>()
        .add(InfoUpdated(info.copyWith(answers: info.answers)));
    context
        .read<InfoBloc>()
        .add(InfoUpdated(info.copyWith(answers: info.answers)));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        SizedBox(
            child: DottedBorder(
          color: Theme.of(context).colorScheme.primary,
          strokeWidth: 1,
          dashPattern: widget.prompts[0] != "" ? [1, 0] : [10, 6],
          borderType: BorderType.RRect,
          radius: const Radius.circular(20),
          padding: const EdgeInsets.all(0),
          child: Pressable.opacity(
            onPressed: () {
              Navigator.of(context).push<void>(MaterialPageRoute(
                builder: (context) => PromptSelectPage(
                    prompt: widget.prompts[0],
                    answer: widget.answers[0],
                    index: 0),
              ));
            },
            child: SizedBox(
              height: 120,
              width: double.infinity,
              child: widget.prompts[0] != ""
                  ? Stack(children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Text(
                                  widget.prompts[0],
                                  style: CustomTextStyle.getTitleStyle(
                                      Theme.of(context).colorScheme.onSecondary,
                                      16,
                                      FontWeight.w700),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Text(
                                  widget.answers[0],
                                  style: CustomTextStyle.getTitleStyle(
                                      Theme.of(context).colorScheme.onSecondary,
                                      16,
                                      FontWeight.w400),
                                ),
                              ),
                            ]),
                      ),
                      Positioned(
                        right: -2.5,
                        top: 0,
                        child: GestureDetector(
                            onTap: () {
                              popPrompt(0);
                            },
                            child: SvgPicture.asset(
                              "assets/icons/close.svg",
                              fit: BoxFit.fitWidth,
                            )),
                      )
                    ])
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Select a prompt',
                          style: TextStyle(
                            color: Color(0xFF828282),
                            fontSize: 16,
                            fontFamily: 'Noto Sans',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 4),
                        SvgPicture.asset("assets/icons/add.svg"),
                      ],
                    ),
            ),
          ),
        )),
        const SizedBox(height: 12),
        SizedBox(
            child: DottedBorder(
          color: Theme.of(context).colorScheme.primary,
          strokeWidth: 1,
          dashPattern: widget.prompts[1] != "" ? [1, 0] : [10, 6],
          borderType: BorderType.RRect,
          radius: const Radius.circular(20),
          padding: const EdgeInsets.all(0),
          child: Pressable.opacity(
            onPressed: () {
              Navigator.of(context).push<void>(MaterialPageRoute(
                builder: (context) => PromptSelectPage(
                    prompt: widget.prompts[1],
                    answer: widget.answers[1],
                    index: 1),
              ));
            },
            child: SizedBox(
              height: 120,
              width: double.infinity,
              child: widget.prompts[1] != ""
                  ? Stack(children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Text(
                                  widget.prompts[1],
                                  style: CustomTextStyle.getTitleStyle(
                                      Theme.of(context).colorScheme.onSecondary,
                                      16,
                                      FontWeight.w700),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Text(
                                  widget.answers[1],
                                  style: CustomTextStyle.getTitleStyle(
                                      Theme.of(context).colorScheme.onSecondary,
                                      16,
                                      FontWeight.w400),
                                ),
                              ),
                            ]),
                      ),
                      Positioned(
                        right: -2.5,
                        top: 0,
                        child: GestureDetector(
                            onTap: () {
                              popPrompt(1);
                            },
                            child: SvgPicture.asset(
                              "assets/icons/close.svg",
                              fit: BoxFit.fitWidth,
                            )),
                      )
                    ])
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Select a prompt',
                          style: TextStyle(
                            color: Color(0xFF828282),
                            fontSize: 16,
                            fontFamily: 'Noto Sans',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 4),
                        SvgPicture.asset("assets/icons/add.svg"),
                      ],
                    ),
            ),
          ),
        )),
        const SizedBox(height: 12),
        SizedBox(
            child: DottedBorder(
          color: Theme.of(context).colorScheme.primary,
          strokeWidth: 1,
          dashPattern: widget.prompts[2] != "" ? [1, 0] : [10, 6],
          borderType: BorderType.RRect,
          radius: const Radius.circular(20),
          padding: const EdgeInsets.all(0),
          child: Pressable.opacity(
            onPressed: () {
              Navigator.of(context).push<void>(MaterialPageRoute(
                builder: (context) => PromptSelectPage(
                    prompt: widget.prompts[2],
                    answer: widget.answers[2],
                    index: 2),
              ));
            },
            child: SizedBox(
              height: 120,
              width: double.infinity,
              child: widget.prompts[2] != ""
                  ? Stack(children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Text(
                                  widget.prompts[2],
                                  style: CustomTextStyle.getTitleStyle(
                                      Theme.of(context).colorScheme.onSecondary,
                                      16,
                                      FontWeight.w700),
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: Text(
                                  widget.answers[2],
                                  style: CustomTextStyle.getTitleStyle(
                                      Theme.of(context).colorScheme.onSecondary,
                                      16,
                                      FontWeight.w400),
                                ),
                              ),
                            ]),
                      ),
                      Positioned(
                        right: -2.5,
                        top: 0,
                        child: GestureDetector(
                            onTap: () {
                              popPrompt(2);
                            },
                            child: SvgPicture.asset(
                              "assets/icons/close.svg",
                              fit: BoxFit.fitWidth,
                            )),
                      )
                    ])
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Select a prompt',
                          style: TextStyle(
                            color: Color(0xFF828282),
                            fontSize: 16,
                            fontFamily: 'Noto Sans',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(width: 4),
                        SvgPicture.asset("assets/icons/add.svg"),
                      ],
                    ),
            ),
          ),
        )),
        const SizedBox(height: 34),
        SizedBox(
          height: 62,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/icons/star.svg",
                fit: BoxFit.cover,
              ),
              Expanded(
                child: Container(
                  height: 62,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: ShapeDecoration(
                    color: const Color(0x0C9D9D9D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(36),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SizedBox(
                          child: Text(
                            'We recommend you fill in all 3 prompts to find a match quicker',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFF95F80),
                              fontSize: 14,
                              fontFamily: 'Noto Sans',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
