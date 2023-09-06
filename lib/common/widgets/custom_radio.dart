// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:pressable/pressable.dart';

class CustomRadio extends StatefulWidget {
  final String value;
  final String? groupValue;
  final Function onChange;
  const CustomRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChange,
  });

  @override
  _CustomRadioState createState() => _CustomRadioState();
}

class _CustomRadioState extends State<CustomRadio> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onBackground,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Pressable.opacity(
              onPressed: () {
                widget.onChange(widget.value);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Text(
                        widget.value,
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
                  SizedBox(
                    width: 10,
                    height: 10,
                    child: Radio(
                      value: widget.value,
                      activeColor: Theme.of(context).colorScheme.primary,
                      groupValue: widget.groupValue,
                      onChanged: (value) {
                        widget.onChange(value);
                      },
                    ),
                  ),
                ],
              ),
            )),
        const SizedBox(height: 12),
      ],
    );
  }
}
