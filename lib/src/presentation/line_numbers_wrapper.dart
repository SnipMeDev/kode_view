import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kode_view/src/presentation/styles/text_styles.dart';
import 'package:kode_view/src/utils/extensions/text_extensions.dart';

class LineNumbersWrapper extends StatelessWidget {
  const LineNumbersWrapper({
    required this.enableLineNumbers,
    required this.linesNumber,
    required this.child,
    this.fontSize,
    this.lineNumberBackgroundColor,
    this.lineNumberColor,
    super.key,
  });
  final bool enableLineNumbers;
  final int linesNumber;
  final Color? lineNumberBackgroundColor;
  final Color? lineNumberColor;
  final double? fontSize;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    double maxWidth = 0;
    for (int i = 0; i < linesNumber; i++) {
      String lineNumber = i.toString();
      double width = lineNumber.getTextWidth(
        TextStyles.lineNumber(
          color: lineNumberColor,
          fontSize: fontSize,
        ),
      );
      maxWidth = max(maxWidth, width);
    }

    return Row(
      children: [
        if (enableLineNumbers) ...[
          Container(
            constraints: BoxConstraints(
              maxWidth: maxWidth + 10,
            ),
            color: lineNumberBackgroundColor,
            child: ListView.builder(
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
