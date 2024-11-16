import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:highlights_plugin/highlights_plugin.dart';
import 'package:highlights_plugin/model/code_highlight.dart';
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
    super.key,
  });

  final splitter = const LineSplitter();
  final String code;
  final int? maxLines;
  final bool? showCursor;
  final TextSelectionOptions? options;
  final GestureTapCallback? onTap;

  final String? language;
  final String? theme;

  const CodeTextView.preview({
    required this.code,
    this.options,
    this.onTap,
    this.showCursor,
    this.language,
    this.theme,
    super.key,
  }) : maxLines = 5;

  @override
  Widget build(BuildContext context) {
    final maxLinesOrAll = maxLines ?? splitter.convert(code).length;
    return FutureBuilder(
      initialData: const <TextSpan>[],
      future: (_highlights()).then(
        (value) => value.toSpans(
          code.lines(maxLinesOrAll),
          TextStyles.code(code).style!,
        ),
      ),
      builder: (_, value) {
        return Expanded(
          child: SelectableText.rich(
            TextSpan(children: value.requireData),
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

  Future<List<CodeHighlight>> _highlights() async =>
      await HighlightsPlugin().getHighlights(
        code,
        language,
        theme,
        [],
      );
}
