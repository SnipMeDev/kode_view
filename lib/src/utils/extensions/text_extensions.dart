import 'dart:convert';

import 'package:flutter/material.dart';

extension TextExtensions on String {
  String get route => '/$this';

  List<String> splitByIndices(List<int> splitters) {
    List<String> result = [];

    if (splitters.any((splitIndex) => splitIndex < 0)) {
      throw Exception("Index for word must be at least 0");
    }

    if (splitters.any((splitIndex) => splitIndex < 0)) {
      throw Exception("Index for word must at most $length");
    }

    if (splitters.isEmpty) {
      throw Exception("There must be at least one splitter provided");
    }

    splitters.sort((a, b) => a.compareTo(b));

    if (splitters.first > 0) {
      splitters.insert(0, 0);
    }

    if (splitters.last < length) {
      splitters.add(length);
    }

    for (int i = 0; i < splitters.length; i++) {
      final splitter = splitters[i];

      if (splitter == splitters.last) {
        break;
      }

      final nextSplitter = splitters[i + 1];
      result.add(substring(splitter, nextSplitter));
    }

    return result;
  }

  String lines(int count) {
    final split = const LineSplitter().convert(this).take(count);
    return split.join('\n');
  }

  double getTextWidth(TextStyle? style) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: this,
        style: style,
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.size.width;
  }
}
