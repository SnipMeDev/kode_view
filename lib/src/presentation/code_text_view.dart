import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:highlights_plugin/highlights_plugin.dart';
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
  final TextStyle? textStyle;

  const CodeTextView.preview({
    required this.code,
    this.options,
    this.onTap,
    this.showCursor,
    this.language,
    this.theme,
    this.textStyle,
    super.key,
  }) : maxLines = 5;

  @override
  Widget build(BuildContext context) {
    final maxLinesOrAll = maxLines ?? splitter.convert(code).length;

    return FutureBuilder(
      initialData: const <TextSpan>[],
      future: _highlights(maxLinesOrAll),
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

  Future<List<TextSpan>> _highlights(int maxLinesOrAll) async {
    final highlights = await HighlightsPlugin().getHighlights(
      code,
      language,
      theme,
      [],
    );
    return highlights.toSpans(
      code.lines(maxLinesOrAll),
      textStyle ?? TextStyles.code(code).style!,
    );
  }
}
