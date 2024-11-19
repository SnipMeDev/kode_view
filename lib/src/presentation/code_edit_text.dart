import 'package:flutter/material.dart';
import 'package:kode_view/src/presentation/styles/text_styles.dart';
import 'package:kode_view/src/presentation/syntax_highlighting_controller.dart';
import 'package:kode_view/src/presentation/text_selection_options.dart';

class CodeEditText extends StatefulWidget {
  const CodeEditText({
    required this.code,

    // Core functionality
    this.controller,
    this.language,
    this.theme,
    this.textStyle,
    this.maxLines,

    // Appearance
    this.decoration,
    this.enableLineNumbers = false,
    this.lineNumberColor,
    this.lineNumberBackgroundColor,

    // Interaction
    this.showCursor,
    this.options,
    this.onTap,

    // Debugging
    this.debug = false,

    // Flutter widget key
    super.key,
  });

  // Required
  final String code;

  // Core functionality
  final SyntaxHighlightingController? controller;
  final String? language;
  final String? theme;
  final TextStyle? textStyle;
  final int? maxLines;

  // Appearance
  final InputDecoration? decoration;
  final bool enableLineNumbers;
  final Color? lineNumberColor;
  final Color? lineNumberBackgroundColor;

  // Interaction
  final bool? showCursor;
  final TextSelectionOptions? options;
  final GestureTapCallback? onTap;

  // Debugging
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
        SyntaxHighlightingController(text: widget.code, debug: widget.debug,
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
        return Row(
          children: [
            if (widget.enableLineNumbers) ...[
              Container(
                color: widget.lineNumberBackgroundColor,
                width: 40,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _controller.text.split('\n').length,
                  itemBuilder: (context, index) {
                    return Text(
                      '${index + 1}',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: widget.lineNumberColor ?? Colors.black54,
                        fontSize: widget.textStyle?.fontSize ??
                            const TextStyles.code('').style!.fontSize,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                width: 4,
              ),
            ],
            Expanded(
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
          ],
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
