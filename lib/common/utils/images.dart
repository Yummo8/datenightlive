// ignore_for_file: prefer_const_constructors, body_might_complete_normally_catch_error, depend_on_referenced_packages

import 'dart:io';
import 'dart:async';
import 'package:path/path.dart' as path_lib;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:DNL/common/values/constants.dart';
import 'package:uuid/uuid.dart';

ImageProvider getNetworkImage(String url) {
  try {
    if (url == "") {
      return const AssetImage('assets/images/image_preview.png');
    }

    final image = CachedNetworkImageProvider(url);
    return image;
  } catch (e) {
    return const AssetImage('assets/images/image_preview.png');
  }
}

bool isNetworkImage(String url) {
  if (url.startsWith("http") == true) {
    return true;
  }
  return false;
}

Future<String> uploadFile(String path, File file) async {
  FirebaseStorage storage = FirebaseStorage.instance;
  Reference ref = storage.ref().child(path);
  UploadTask uploadTask = ref.putFile(file);
  String url = "";
  await uploadTask.whenComplete(() async {
    url = await ref.getDownloadURL();
  }).catchError((err) {
    debugPrint(err.toString());
  });
  return url;
}

Future<Media> uploadMedia(String uid, Media media) async {
  if (media.type != "") {
    String extension, filename, path;
    extension = path_lib.extension(media.media);
    filename = generateRandomString();
    path = 'user/$uid/media/$filename$extension';
    String mediaPath = await uploadFile(path, File(media.media));

    extension = path_lib.extension(media.thumbnail);
    filename = generateRandomString();
    path = 'user/$uid/thumbnail/$filename$extension';
    String thumbnailPath = await uploadFile(path, File(media.thumbnail));
    return Media(
      index: media.index,
      type: media.type,
      media: mediaPath,
      thumbnail: thumbnailPath,
      duration: media.duration,
    );
  } else {
    return Media(
      index: media.index,
      type: '',
      media: '',
      thumbnail: '',
      duration: '',
    );
  }
}

String generateRandomString() {
  final Uuid uuid = Uuid();
  return uuid.v1();
}
