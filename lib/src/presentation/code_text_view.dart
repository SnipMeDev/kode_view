import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:highlights_plugin/highlights_plugin.dart';
import 'package:kode_view/src/presentation/line_numbers_wrapper.dart';
import 'package:kode_view/src/presentation/styles/text_styles.dart';
import 'package:kode_view/src/presentation/text_selection_options.dart';
import 'package:kode_view/src/utils/extensions/collection_extensions.dart';
import 'package:kode_view/src/utils/extensions/text_extensions.dart';

class CodeTextView extends StatefulWidget {
  const CodeTextView({
    required this.code,
    this.maxLines,
    this.options,
    this.showCursor,
    this.onTap,
    this.language,
    this.theme,
    this.textStyle = const TextStyles.code(),
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
  final TextStyle textStyle;

  const CodeTextView.preview({
    required this.code,
    this.options,
    this.onTap,
    this.showCursor,
    this.language,
    this.theme,
    this.textStyle = const TextStyles.code(),
    this.enableLineNumbers = false,
    super.key,
  }) : maxLines = 5;

  @override
  State<CodeTextView> createState() => _CodeTextViewState();
}

class _CodeTextViewState extends State<CodeTextView> {
  final GlobalKey selectableTextkey = GlobalKey();
  double height = 0;

  void _getTextFieldHeight() {
    final RenderBox renderBox =
        selectableTextkey.currentContext?.findRenderObject() as RenderBox;
    setState(() {
      height = renderBox.size.height;
    });
  }

  @override
  Widget build(BuildContext context) {
    final maxLinesOrAll =
        widget.maxLines ?? widget.splitter.convert(widget.code).length;
    final ScrollController controller = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getTextFieldHeight();
    });

    return FutureBuilder(
      initialData: const <TextSpan>[],
      future: _highlights(maxLinesOrAll),
      builder: (_, value) {
        return LineNumbersWrapper(
          scrollController: controller,
          showLineNumbers: widget.enableLineNumbers,
          height: height,
          linesNumber: maxLinesOrAll,
          fontSize: widget.textStyle.fontSize,
          child: SelectableText.rich(
            TextSpan(children: value.requireData),
            key: selectableTextkey,
            style: widget.textStyle,
            minLines: 1,
            maxLines: maxLinesOrAll,
            onTap: () {},
            contextMenuBuilder: widget.options != null
                ? (context, editableTextState) =>
                    widget.options!.toolbarOptions(context, editableTextState)
                : null,
            enableInteractiveSelection: widget.options != null,
            showCursor: widget.showCursor ?? false,
            scrollPhysics: const ClampingScrollPhysics(),
          ),
        );
      },
    );
  }

  Future<List<TextSpan>> _highlights(int maxLinesOrAll) async {
    final highlights = await HighlightsPlugin().getHighlights(
      widget.code,
      widget.language,
      widget.theme,
      [],
    );
    return highlights.toSpans(
      widget.code.lines(maxLinesOrAll),
      widget.textStyle,
    );
  }
}
