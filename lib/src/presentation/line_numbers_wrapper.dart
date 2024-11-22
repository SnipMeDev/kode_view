import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kode_view/src/presentation/styles/text_styles.dart';
import 'package:kode_view/src/utils/extensions/text_extensions.dart';

class LineNumbersWrapper extends StatelessWidget {
  const LineNumbersWrapper({
    required this.scrollController,
    required this.showLineNumbers,
    required this.linesCount,
    required this.height,
    required this.child,
    this.fontSize,
    this.lineNumberBackgroundColor,
    this.lineNumberColor,
    super.key,
  });

  final ScrollController scrollController;
  final bool showLineNumbers;
  final int linesCount;
  final double height;
  final Widget child;
  final Color? lineNumberBackgroundColor;
  final Color? lineNumberColor;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyles.lineNumber(
      color: lineNumberColor,
      fontSize: fontSize,
    );

    final maxLineWidth = (linesCount).toString().getTextWidth(textStyle);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLineNumbers) ...[
          Container(
            constraints: BoxConstraints(
              maxWidth: maxLineWidth,
              maxHeight: height,
            ),
            color: lineNumberBackgroundColor,
            child: ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              controller: scrollController,
              itemCount: linesCount,
              itemBuilder: (context, index) {
                return Text(
                  '${index + 1}',
                  textAlign: TextAlign.right,
                  style: textStyle,
                );
              },
            ),
          ),
          const SizedBox(width: 4),
        ],
        Expanded(
          child: child,
        ),
      ],
    );
  }
}
