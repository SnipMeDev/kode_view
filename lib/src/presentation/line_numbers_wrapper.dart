import 'package:flutter/material.dart';
import 'package:kode_view/src/presentation/styles/text_styles.dart';

class LineNumbersWrapper extends StatelessWidget {
  const LineNumbersWrapper({
    required this.enableLineNumbers,
    required this.linesNumber,
    required this.child,
    this.textStyle,
    this.lineNumberBackgroundColor,
    this.lineNumberColor,
    super.key,
  });
  final bool enableLineNumbers;
  final int linesNumber;
  final Color? lineNumberBackgroundColor;
  final Color? lineNumberColor;
  final TextStyle? textStyle;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (enableLineNumbers) ...[
          Container(
            color: lineNumberBackgroundColor,
            width: 40,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: linesNumber,
              itemBuilder: (context, index) {
                return Text(
                  '${index + 1}',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    color: lineNumberColor ?? Colors.black54,
                    fontSize: textStyle?.fontSize ??
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
          child: child,
        ),
      ],
    );
  }
}
