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
    super.key,
    required this.code,
    this.maxLines,
    this.options,
    this.onTap,
    this.language,
    this.theme,
  });

  final splitter = const LineSplitter();
  final String code;
  final int? maxLines;
  final TextSelectionOptions? options;
  final GestureTapCallback? onTap;

  final String? language;
  final String? theme;

  const CodeTextView.preview(
      {super.key,
      required this.code,
      this.options,
      this.onTap,
      this.language,
      this.theme})
      : maxLines = 5;

  @override
  Widget build(BuildContext context) {
    final maxLinesOrAll = maxLines ?? splitter.convert(code).length;
    return FutureBuilder(
      initialData: const <TextSpan>[],
      future: (_highlights()).then((value) => value.toSpans(
          code.lines(maxLinesOrAll), TextStyles.code(code).style!)),
      builder: (_, value) {
        return SelectableText.rich(
          TextSpan(children: value.requireData),
          minLines: 1,
          maxLines: maxLinesOrAll,
          onTap: () {},
          toolbarOptions: options?.toolbarOptions,
          showCursor: options?.showCursor ?? false,
          enableInteractiveSelection: false,
          scrollPhysics: const NeverScrollableScrollPhysics(),
        );
      },
    );
  }

  Future<List<CodeHighlight>> _highlights() async {
    debugPrint(code);
    debugPrint(language);
    debugPrint(theme);
    var a = await HighlightsPlugin().getHighlights(
      code,
      language,
      theme,
      [],
    );
    debugPrint(a.toString());
    return a;
  }
}
