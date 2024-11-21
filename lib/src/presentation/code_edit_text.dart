import 'package:flutter/material.dart';
import 'package:kode_view/src/presentation/line_numbers_wrapper.dart';
import 'package:kode_view/src/presentation/styles/text_styles.dart';
import 'package:kode_view/src/presentation/syntax_highlighting_controller.dart';
import 'package:kode_view/src/presentation/text_selection_options.dart';

class CodeEditText extends StatefulWidget {
  const CodeEditText({
    required this.code,
    this.controller,
    this.language,
    this.theme,
    this.textStyle = const TextStyles.code(),
    this.maxLines,
    this.decoration,
    this.showLineNumbers = false,
    this.lineNumberColor,
    this.lineNumberBackgroundColor,
    this.showCursor,
    this.options,
    this.onTap,
    this.debug = false,
    super.key,
  });

  final String code;

  final SyntaxHighlightingController? controller;
  final String? language;
  final String? theme;
  final TextStyle textStyle;
  final int? maxLines;

  final InputDecoration? decoration;
  final bool showLineNumbers;
  final Color? lineNumberColor;
  final Color? lineNumberBackgroundColor;

  final bool? showCursor;
  final TextSelectionOptions? options;
  final GestureTapCallback? onTap;

  final bool debug;

  @override
  State<CodeEditText> createState() => _CodeEditTextState();
}

class _CodeEditTextState extends State<CodeEditText> {
  late SyntaxHighlightingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        SyntaxHighlightingController(
          text: widget.code,
          debug: widget.debug,
        )
      ..addListener(() {
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
        return LineNumbersWrapper(
          enableLineNumbers: widget.showLineNumbers,
          linesNumber: _controller.text.split('\n').length,
          fontSize: widget.textStyle.fontSize,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: IntrinsicWidth(
              child: TextField(
                controller: _controller,
                style: widget.textStyle,
                onTap: widget.onTap,
                minLines: 1,
                maxLines: widget.maxLines,
                contextMenuBuilder: widget.options != null
                    ? (context, editableTextState) => widget.options!
                        .toolbarOptions(context, editableTextState)
                    : null,
                enableInteractiveSelection: widget.options != null,
                showCursor: widget.showCursor ?? true,
                scrollPhysics: const ClampingScrollPhysics(),
                decoration: widget.decoration,
              ),
            ),
          ),
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
