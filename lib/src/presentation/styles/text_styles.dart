import 'package:flutter/material.dart';

class TextStyles extends TextStyle {
  const TextStyles.code()
      : super(
          fontSize: 16,
          fontStyle: FontStyle.normal,
        );
  const TextStyles.lineNumber({Color? color, double? fontSize})
      : super(
          color: Colors.black54,
          fontSize: fontSize ?? 16,
          fontStyle: FontStyle.normal,
          height: 1.5,
        );
}
