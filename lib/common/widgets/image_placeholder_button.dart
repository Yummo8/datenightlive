import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:DNL/common/utils/images.dart';
import 'package:pressable/pressable.dart';
import 'dart:io' as io;

class ImagePlaceholderButton extends StatelessWidget {
  final Function onPressed;
  final Function onDelete;
  final dynamic image;
  final String duration;

  const ImagePlaceholderButton(
      {super.key,
      this.image,
      required this.duration,
      required this.onPressed,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    List<String> options = [
      'Choose From library',
      'Take Photo',
      'Record Video'
    ];
    return Pressable.opacity(
      onPressed: () {
        if (image == "") {
          showCupertinoModalPopup(
            context: context,
            builder: (BuildContext context) => CupertinoActionSheet(
                actions: options
                    .map((e) => CupertinoActionSheetAction(
                          child: Text(e),
                          onPressed: () {
                            Navigator.pop(context, e);
                            onPressed(e);
                          },
                        ))
                    .toList(),
                cancelButton: CupertinoActionSheetAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                  },
                  child: const Text('Cancel'),
                )),
          );
        }
      },
      child: SizedBox(
          child: DottedBorder(
              color: image != ""
                  ? Colors.transparent
                  : Theme.of(context).colorScheme.onSurface,
              strokeWidth: 2.5,
              dashPattern: const [8, 8],
              padding: const EdgeInsets.all(0),
              borderType: BorderType.RRect,
              radius: const Radius.circular(20),
              child: Container(
                  height: 110,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                      image: (image != ""
                          ? DecorationImage(
                              image: isNetworkImage(image)
                                  ? getNetworkImage(image)
                                  : Image.file(io.File(image)).image,
                              fit: BoxFit.cover)
                          : null)),
                  child: image == ""
                      ? Center(
                          child: SvgPicture.asset(
                          "assets/icons/attach.svg",
                          fit: BoxFit.cover,
                        ))
                      : Stack(children: [
                          Container(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              duration,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: GestureDetector(
                                onTap: () {
                                  onDelete();
                                },
                                child: SvgPicture.asset(
                                  "assets/icons/close.svg",
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ])))),
    );
  }
}
