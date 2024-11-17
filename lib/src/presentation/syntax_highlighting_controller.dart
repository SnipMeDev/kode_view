import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:highlights_plugin/highlights_plugin.dart';
import 'package:kode_view/src/presentation/styles/text_styles.dart';
import 'package:kode_view/src/utils/extensions/collection_extensions.dart';
import 'package:kode_view/src/utils/extensions/text_extensions.dart';

class SyntaxHighlightingController extends TextEditingController {
  List<TextSpan> textSpans = [];
  final splitter = const LineSplitter();

  void updateSyntaxHighlighting({
    String? theme,
    String? language,
    int? maxLines,
    TextStyle? textStyle,
  }) async {
    final maxLinesOrAll = maxLines ?? splitter.convert(text).length;
    final highlightedText = await _highlights(
      maxLinesOrAll: maxLinesOrAll,
      language: language,
      theme: theme,
      textStyle: textStyle,
    );
    textSpans = highlightedText;
  }

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    return TextSpan(children: textSpans, style: style);
  }

  Future<List<TextSpan>> _highlights({
    required int maxLinesOrAll,
    required String? language,
    required String? theme,
    required TextStyle? textStyle,
  }) async {
    final highlights = await HighlightsPlugin().getHighlights(
      text,
      language,
      theme,
      [],
    );
    return highlights.toSpans(
      text.lines(maxLinesOrAll),
      textStyle ?? TextStyles.code(text).style!,
    );
  }
}
