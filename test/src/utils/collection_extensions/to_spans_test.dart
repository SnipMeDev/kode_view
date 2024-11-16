import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:highlights_plugin/model/code_highlight.dart';
import 'package:highlights_plugin/model/phrase_location.dart';
import 'package:kode_view/src/utils/extensions/collection_extensions.dart';

void main() {
  group('toSpans tests', () {
    test('should return base text when no tokens are provided', () async {
      const text = 'Hello World';
      const baseStyle = TextStyle(color: Colors.black);
      final codeHighlights = <CodeHighlight>[];

      final spans = await codeHighlights.toSpans(text, baseStyle);

      expect(spans.length, 1);
      expect(spans.first.text, text);
      expect(spans.first.style!.color, Colors.black);
    });

    test('should apply colors to tokens correctly', () async {
      const text = 'Hello World';
      const baseStyle = TextStyle(color: Colors.black);
      final codeHighlights = [
        ColorHighlight(
          location: PhraseLocation(start: 0, end: 5),
          rgb: 0xFF00FF00,
        ),
        ColorHighlight(
          location: PhraseLocation(start: 6, end: 11),
          rgb: 0xFFFF0000,
        ),
      ];

      final spans = await codeHighlights.toSpans(text, baseStyle);

      expect(spans.length, 3);
      expect(spans[0].style!.color, const Color(0xFF00FF00));
      expect(spans[2].style!.color, const Color(0xFFFF0000));
    });

    test('should filter out duplicate tokens', () async {
      const text = 'Hello Hello World';
      const baseStyle = TextStyle(color: Colors.black);
      final codeHighlights = [
        ColorHighlight(
          location: PhraseLocation(start: 0, end: 5),
          rgb: 0xFF00FF00,
        ), // "Hello"
        ColorHighlight(
          location: PhraseLocation(start: 0, end: 5),
          rgb: 0xFF00FF00,
        ), // Duplicate "Hello"
        ColorHighlight(
          location: PhraseLocation(start: 6, end: 11),
          rgb: 0xFFFF0000,
        ), // "Hello"
        ColorHighlight(
          location: PhraseLocation(start: 12, end: 17),
          rgb: 0xFFFF0000,
        ), // "World"
      ];

      final spans = await codeHighlights.toSpans(text, baseStyle);

      expect(spans.length, 5);
      expect(spans[0].text, 'Hello');
      expect(spans[1].text, ' ');
      expect(spans[2].text, 'Hello');
      expect(spans[3].text, ' ');
      expect(spans[4].text, 'World');
    });

    test('should split text into phrases based on token indices', () async {
      const text = 'Hello World';
      const baseStyle = TextStyle(color: Colors.black);
      final codeHighlights = [
        ColorHighlight(
          location: PhraseLocation(start: 0, end: 5),
          rgb: 0xFF00FF00,
        ), // "Hello"
        ColorHighlight(
          location: PhraseLocation(start: 6, end: 11),
          rgb: 0xFFFF0000,
        ), // "World"
      ];

      final spans = await codeHighlights.toSpans(text, baseStyle);

      expect(spans.length, 3);
      expect(spans[0].text, 'Hello');
      expect(spans[1].text, ' ');
      expect(spans[2].text, 'World');
    });

    test('should handle empty highlight list gracefully', () async {
      const text = 'Hello';
      const baseStyle = TextStyle(color: Colors.black);
      final codeHighlights = <CodeHighlight>[];

      final spans = await codeHighlights.toSpans(text, baseStyle);

      expect(spans.length, 1);
      expect(spans.first.text, 'Hello');
      expect(spans.first.style!.color, Colors.black);
    });
  });
}
