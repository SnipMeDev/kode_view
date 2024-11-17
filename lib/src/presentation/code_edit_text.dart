import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kode_view/src/presentation/syntax_highlighting_controller.dart';
import 'package:kode_view/src/presentation/text_selection_options.dart';

class CodeEditText extends StatefulWidget {
  const CodeEditText({
    required this.code,
    this.maxLines,
    this.options,
    this.showCursor,
    this.onTap,
    this.language,
    this.theme,
    this.textStyle,
    this.decoration,
    super.key,
  });

  final String code;
  final int? maxLines;
  final bool? showCursor;
  final TextSelectionOptions? options;
  final InputDecoration? decoration;
  final GestureTapCallback? onTap;

  final String? language;
  final String? theme;
  final TextStyle? textStyle;

  @override
  State<CodeEditText> createState() => _CodeEditTextState();
}

class _CodeEditTextState extends State<CodeEditText> {
  late SyntaxHighlightingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SyntaxHighlightingController();

    _controller.addListener(() {
      _controller.updateSyntaxHighlighting(
        language: widget.language,
        theme: widget.theme,
        maxLines: widget.maxLines,
        textStyle: widget.textStyle,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    const splitter = LineSplitter();
    final maxLinesOrAll =
        widget.maxLines ?? splitter.convert(widget.code).length;

    return TextField(
      controller: _controller,
      onTap: widget.onTap,
      minLines: 1,
      maxLines: maxLinesOrAll,
      contextMenuBuilder: widget.options != null
          ? (context, editableTextState) =>
              widget.options!.toolbarOptions(context, editableTextState)
          : null,
      enableInteractiveSelection: widget.options != null,
      showCursor: widget.showCursor ?? true,
      scrollPhysics: const ClampingScrollPhysics(),
      decoration: widget.decoration,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
