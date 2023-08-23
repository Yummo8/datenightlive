import 'package:flutter/material.dart';

class OptionItems<T> {
  final T Function(String text) createItem;
  final Widget Function(String text) createItemBuilder;
  final bool pickCreatedItem;

  final Function(T)? onItemCreated;

  const OptionItems({
    required this.createItem,
    required this.createItemBuilder,
    this.pickCreatedItem = false,
    this.onItemCreated,
  });
}
