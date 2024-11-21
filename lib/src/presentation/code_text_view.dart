import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:highlights_plugin/highlights_plugin.dart';
import 'package:kode_view/src/presentation/line_numbers_wrapper.dart';
import 'package:kode_view/src/presentation/styles/text_styles.dart';
import 'package:kode_view/src/presentation/text_selection_options.dart';
import 'package:kode_view/src/utils/extensions/collection_extensions.dart';
import 'package:kode_view/src/utils/extensions/text_extensions.dart';

class CodeTextView extends StatelessWidget {
  const CodeTextView({
    required this.code,
    this.maxLines,
    this.options,
    this.showCursor,
    this.onTap,
    this.language,
    this.theme,
    this.textStyle,
    this.enableLineNumbers = false,
    super.key,
  });

  final splitter = const LineSplitter();
  final String code;
  final int? maxLines;
  final bool? showCursor;
  final TextSelectionOptions? options;
  final GestureTapCallback? onTap;
  final bool enableLineNumbers;

  final String? language;
  final String? theme;
  final TextStyle? textStyle;

  const CodeTextView.preview({
    required this.code,
    this.options,
    this.onTap,
    this.showCursor,
    this.language,
    this.theme,
    this.textStyle,
    this.enableLineNumbers = false,
    super.key,
  }) : maxLines = 5;

  @override
  Widget build(BuildContext context) {
    final maxLinesOrAll = maxLines ?? splitter.convert(code).length;

    return FutureBuilder(
      initialData: const <TextSpan>[],
      future: _highlights(maxLinesOrAll),
      builder: (_, value) {
        return LineNumbersWrapper(
          enableLineNumbers: enableLineNumbers,
          linesNumber: maxLinesOrAll,
          textStyle: textStyle,
          child: SelectableText.rich(
            TextSpan(children: value.requireData),
            style: textStyle ?? const TextStyles.code(),
            minLines: 1,
            maxLines: maxLinesOrAll,
            onTap: () {},
            contextMenuBuilder: options != null
                ? (context, editableTextState) =>
                    options!.toolbarOptions(context, editableTextState)
                : null,
            enableInteractiveSelection: options != null,
            showCursor: showCursor ?? false,
            scrollPhysics: const ClampingScrollPhysics(),
          ),
        );
      },
    );
  }

  Future<List<TextSpan>> _highlights(int maxLinesOrAll) async {
    final highlights = await HighlightsPlugin().getHighlights(
      code,
      language,
      theme,
      [],
    );
    return highlights.toSpans(
      code.lines(maxLinesOrAll),
      textStyle ?? const TextStyles.code(),
    );
  }
}
