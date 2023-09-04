// ignore_for_file: library_private_types_in_public_api

import 'package:DNL/view/profile/widgets/icon_check_button.dart';
import 'package:flutter/material.dart';

class SearchChoose extends StatefulWidget {
  final List<bool>? search;
  final Function onChange;

  const SearchChoose({
    super.key,
    this.search,
    required this.onChange,
  });

  @override
  _SearchChooseState createState() => _SearchChooseState();
}

class _SearchChooseState extends State<SearchChoose> {
  String option = "";

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: IconCheckButton(
                      title: "Just for fun",
                      icon: "fun",
                      checked: widget.search![0],
                      onPressed: () {
                        setState(() {
                          widget.search![0] = !widget.search![0];
                        });
                        widget.onChange(widget.search);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: IconCheckButton(
                      title: "Short term relationship",
                      icon: "short",
                      checked: widget.search![1],
                      onPressed: () {
                        setState(() {
                          widget.search![1] = !widget.search![1];
                        });
                        widget.onChange(widget.search);
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: IconCheckButton(
                      title: "Marriage",
                      icon: "marriage",
                      checked: widget.search![2],
                      onPressed: () {
                        setState(() {
                          widget.search![2] = !widget.search![2];
                        });
                        widget.onChange(widget.search);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: IconCheckButton(
                      title: "Long term relationship",
                      icon: "long",
                      checked: widget.search![3],
                      onPressed: () {
                        setState(() {
                          widget.search![3] = !widget.search![3];
                        });
                        widget.onChange(widget.search);
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16),
            ]));
  }
}
