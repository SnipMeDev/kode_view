import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:highlights_plugin/highlights_plugin.dart';
import 'package:kode_view/src/presentation/styles/text_styles.dart';
import 'package:kode_view/src/utils/extensions/collection_extensions.dart';

class SyntaxHighlightingController extends TextEditingController {
  ValueNotifier<List<TextSpan>> textSpansNotifier = ValueNotifier([]);
  final splitter = const LineSplitter();

  SyntaxHighlightingController({
    String? text,
    this.debug = false,
  }) : super(text: text);
  final bool debug;

  Future<void> updateSyntaxHighlighting({
    required String code,
    String? theme,
    String? language,
    TextStyle? textStyle,
  }) async {
    try {
      final highlightedText = await _highlights(
        code: code,
        language: language,
        theme: theme,
        textStyle: textStyle,
      );
      textSpansNotifier.value = highlightedText;
    } catch (e, st) {
      if (debug) {
        debugPrint('KodeView CodeEditText error: $e');
        debugPrintStack(stackTrace: st);
      }
    }
  }

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    return TextSpan(children: textSpansNotifier.value, style: style);
  }

  Future<List<TextSpan>> _highlights({
    required String code,
    required String? language,
    required String? theme,
    required TextStyle? textStyle,
  }) async {
    final highlights = await HighlightsPlugin().getHighlights(
      code,
      language,
      theme,
      [],
    );
    return highlights.toSpans(
      code,
      textStyle ?? TextStyles.code(code).style!,
    );
  }
}
