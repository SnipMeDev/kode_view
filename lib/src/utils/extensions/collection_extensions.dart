import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:highlights_plugin/model/code_highlight.dart';
import 'package:kode_view/src/presentation/styles/text_styles.dart';
import 'package:kode_view/src/utils/extensions/text_extensions.dart';

class TokenSpan with EquatableMixin {
  String value;
  Color color;
  int start;
  int end;

  TokenSpan({
    required this.value,
    required this.color,
    required this.start,
    required this.end,
  });

  @override
  List<Object?> get props => [value, color, start, end];
}

extension SyntaxSpanExtension on List<CodeHighlight> {
  Future<List<TextSpan>> toSpans(String text, TextStyle baseStyle) {
    return Future.microtask(() {
      if (isEmpty) return [TextSpan(text: text, style: baseStyle)];

      final tokens = map(
        (token) => TokenSpan(
          value: text.substring(token.location.start, token.location.end),
          color: token is ColorHighlight
              ? Color(token.rgb)
              : baseStyle.color ?? Colors.black,
          start: token.location.start,
          end: token.location.end,
        ),
      );

      final uniqueTokens = tokens.where((tested) {
        final isDuplicated = tokens.any(
          (span) =>
              tested != span &&
              span.value.contains(tested.value) &&
              tested.start >= span.start &&
              tested.end <= span.end,
        );

        return !isDuplicated;
      });

      final tokenIndices =
          uniqueTokens.expand((token) => [token.start, token.end]).toList();

      final phrases =
          tokenIndices.isNotEmpty ? text.splitByIndices(tokenIndices) : [text];

      return phrases.map((phrase) {
        TextStyle style = baseStyle;

        final foundToken = uniqueTokens.firstWhereOrNull(
          (span) => span.value == phrase,
        );

        if (foundToken != null) {
          style =
              TextStyles.code(text).style!.copyWith(color: foundToken.color);
        }

        return TextSpan(text: phrase, style: style);
      }).toList();
    });
  }
}
