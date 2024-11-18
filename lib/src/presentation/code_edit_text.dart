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
    this.debug = false,
    super.key,
  });

  final String code;
  final int? maxLines;
  final bool? showCursor;
  final TextSelectionOptions? options;
  final InputDecoration? decoration;
  final GestureTapCallback? onTap;
  final bool debug;

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
    _controller = SyntaxHighlightingController(
      text: widget.code,
      debug: widget.debug,
    )..addListener(() {
        _controller.updateSyntaxHighlighting(
          code: _controller.text,
          language: widget.language,
          theme: widget.theme,
          textStyle: widget.textStyle,
        );
      });

    _controller.updateSyntaxHighlighting(
      code: _controller.text,
      language: widget.language,
      theme: widget.theme,
      textStyle: widget.textStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _controller.textSpansNotifier,
      builder: (context, __, _) {
        return TextField(
          controller: _controller,
          style: widget.textStyle,
          onTap: widget.onTap,
          minLines: 1,
          maxLines: widget.maxLines,
          contextMenuBuilder: widget.options != null
              ? (context, editableTextState) =>
                  widget.options!.toolbarOptions(context, editableTextState)
              : null,
          enableInteractiveSelection: widget.options != null,
          showCursor: widget.showCursor ?? true,
          scrollPhysics: const ClampingScrollPhysics(),
          decoration: widget.decoration,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
