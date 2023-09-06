// ignore_for_file: unnecessary_new, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:DNL/common/values/colors.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';

class MusicChoose extends StatefulWidget {
  final List<String> music;
  final Function onChange;

  const MusicChoose({
    super.key,
    required this.music,
    required this.onChange,
  });

  @override
  _MusicChooseState createState() => _MusicChooseState();
}

class _MusicChooseState extends State<MusicChoose>
    with AutomaticKeepAliveClientMixin<MusicChoose> {
  final TextEditingController _controller = TextEditingController();
  int a = 1;

  final List<String> list = [
    'Jazz',
    'Rap',
    'Country',
    'Blues',
    'Classical',
    'Pop',
    'R&B',
    'Punk',
    'Metal',
    'Reggae',
    'Afrobeat',
    'Indie',
    'Alternative',
    'Soul',
    'House',
    'Techno',
    'Folk',
    'Disco',
    'Latino',
    'Gospel',
    'K-Pop',
    'EDM',
  ];

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(4, 0, 4, 0),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ThemeColors.input,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            MultiSelectContainer(
                itemsDecoration: MultiSelectDecorations(
                  decoration: BoxDecoration(
                      border: Border.all(color: ThemeColors.primary),
                      borderRadius: BorderRadius.circular(20)),
                  selectedDecoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [ThemeColors.primary, ThemeColors.primary]),
                      border: Border.all(color: ThemeColors.primary),
                      borderRadius: BorderRadius.circular(20)),
                ),
                itemsPadding: const EdgeInsets.only(
                    left: 20, right: 20, top: 5, bottom: 5),
                textStyles: const MultiSelectTextStyles(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ThemeColors.primary,
                      fontSize: 16,
                    ),
                    selectedTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16)),
                items: list
                    .map((e) => MultiSelectCard(value: e, label: e))
                    .toList(),
                onChange: (allSelectedItems, selectedItem) {
                  widget.onChange(allSelectedItems);
                }),
          ],
        ));
  }
}
