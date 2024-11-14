import 'package:flutter/material.dart';
import 'package:kode_view/src/presentation/styles/color_styles.dart';

class TextStyles extends Text {
  final String text;

  const TextStyles.title(this.text, {Key? key})
      : super(
          text,
          key: key,
          style: const TextStyle(fontSize: 16),
        );

  const TextStyles.code(this.text, {Key? key})
      : super(
          text,
          key: key,
          style: const TextStyle(
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        );

  TextStyles.regular(this.text, {Key? key, Color? color})
      : super(
          text,
          key: key,
          style: TextStyle(color: color),
        );

  TextStyles.bold(this.text, {Key? key, Color? color})
      : super(
          text,
          key: key,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        );

  const TextStyles.secondary(this.text, {Key? key})
      : super(
          text,
          key: key,
          style: const TextStyle(color: Colors.grey),
        );

  const TextStyles.secondaryBold(this.text, {Key? key})
      : super(
          text,
          key: key,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        );

  const TextStyles.label(this.text, {Key? key})
      : super(
          text,
          key: key,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        );

  const TextStyles.helper(this.text, {Key? key})
      : super(
          text,
          key: key,
          style: const TextStyle(fontSize: 10, color: Colors.grey),
        );

  TextStyles.appLogo(this.text, {Key? key})
      : super(
          text,
          key: key,
          style: TextStyle(
            fontFamily: 'Kanit',
            fontSize: 24.0,
            color: ColorStyles.accent(),
          ),
        );

  const TextStyles.appBarLogo(this.text, {Key? key})
      : super(
          text,
          key: key,
          style: const TextStyle(
            fontFamily: 'Kanit',
            fontSize: 18.0,
            color: Colors.black,
          ),
        );
}
