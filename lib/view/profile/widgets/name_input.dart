// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:DNL/common/values/custom_text_style.dart';

class NameInput extends StatefulWidget {
  final String firstname;
  final String lastname;
  final Function onChangeFirstname;
  final Function onChangeLastname;

  const NameInput({
    super.key,
    required this.firstname,
    required this.lastname,
    required this.onChangeFirstname,
    required this.onChangeLastname,
  });

  @override
  _NameInputState createState() => _NameInputState();
}

class _NameInputState extends State<NameInput>
    with AutomaticKeepAliveClientMixin<NameInput> {
  final TextEditingController _firstNameEditingController =
      TextEditingController();
  final TextEditingController _secondNameEditingController =
      TextEditingController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _firstNameEditingController.text = widget.firstname;
    _secondNameEditingController.text = widget.lastname;
  }

  @override
  void dispose() {
    _firstNameEditingController.dispose();
    _secondNameEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Theme(
          data: ThemeData(
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent),
          child: TextField(
            autofocus: false,
            style: CustomTextStyle.getInputStyle(
                Theme.of(context).colorScheme.onSecondary),
            decoration: InputDecoration(
                hintText: "First Name (required)",
                fillColor: Theme.of(context).colorScheme.onBackground,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
                hintStyle: CustomTextStyle.getInputStyle(
                    Theme.of(context).colorScheme.onSurface),
                isDense: true),
            controller: _firstNameEditingController,
            onChanged: (String firstname) {
              widget.onChangeFirstname(firstname);
            },
          ),
        ),
        const SizedBox(height: 36),
        Theme(
          data: ThemeData(
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent),
          child: TextField(
            autofocus: false,
            style: CustomTextStyle.getInputStyle(
                Theme.of(context).colorScheme.onSecondary),
            decoration: InputDecoration(
                hintText: "Last Name",
                fillColor: Theme.of(context).colorScheme.onBackground,
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none),
                hintStyle: CustomTextStyle.getInputStyle(
                    Theme.of(context).colorScheme.onSurface),
                isDense: true),
            controller: _secondNameEditingController,
            onChanged: (String lastname) {
              widget.onChangeLastname(lastname);
            },
          ),
        ),
        const SizedBox(height: 10),
        Text("Last Name is optional, and only shared with matches",
            style: CustomTextStyle.getSpanStyle(
                Theme.of(context).colorScheme.onSurface)),
      ],
    );
  }
}
