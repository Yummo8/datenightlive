// ignore_for_file: unnecessary_new, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:DNL/common/values/colors.dart';

class MusicChoose extends StatefulWidget {
  final String music;
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

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _controller.text = widget.music;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      decoration: new BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          border: new Border.all(color: Theme.of(context).colorScheme.outline),
          borderRadius: new BorderRadius.circular(15.0)),
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: _controller,
        maxLength: 200,
        maxLines: 10,
        decoration: const InputDecoration(
          hintText: "My name is ...",
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        style: const TextStyle(color: ThemeColors.onSecondary, fontSize: 15),
        onChanged: (value) {
          widget.onChange(value);
        },
      ),
    );
  }
}
