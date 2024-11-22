import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kode_view/src/presentation/styles/text_styles.dart';
import 'package:kode_view/src/utils/extensions/text_extensions.dart';

class LineNumbersWrapper extends StatelessWidget {
  const LineNumbersWrapper({
    required this.showLineNumbers,
    required this.height,
    required this.scrollController,
    required this.child,
    required this.linesNumber,
    this.fontSize,
    this.lineNumberBackgroundColor,
    this.lineNumberColor,
    super.key,
  });
  final bool showLineNumbers;
  final double height;
  final int linesNumber;
  final Color? lineNumberBackgroundColor;
  final Color? lineNumberColor;
  final double? fontSize;
  final Widget child;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    double maxWidth = 0;
    for (int i = 0; i < linesNumber; i++) {
      String lineNumber = i.toString();
      final width = lineNumber.getTextWidth(
        TextStyles.lineNumber(
          color: lineNumberColor,
          fontSize: fontSize,
        ),
      );
      maxWidth = max(maxWidth, width);
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLineNumbers) ...[
          Container(
            constraints: BoxConstraints(
              maxWidth: maxWidth + 10,
              maxHeight: height,
            ),
            color: lineNumberBackgroundColor,
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: scrollController,
              shrinkWrap: true,
              itemCount: linesNumber,
              itemBuilder: (context, index) {
                return Text(
                  '${index + 1}',
                  textAlign: TextAlign.right,
                  style: TextStyles.lineNumber(
                    color: lineNumberColor,
                    fontSize: fontSize,
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
          child: child,
        ),
      ],
    );
  }
}
