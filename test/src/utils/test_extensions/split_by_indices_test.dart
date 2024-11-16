import 'package:flutter_test/flutter_test.dart';
import 'package:kode_view/src/utils/extensions/text_extensions.dart';

void main() {
  group('splitByIndices tests', () {
    test('should split correctly with valid indices', () {
      const input = "HelloWorld";
      final splitters = [5];

      final result = input.splitByIndices(splitters);

      expect(result, ['Hello', 'World']);
    });

    test('should throw an exception if any index is negative', () {
      const input = "HelloWorld";
      final splitters = [-1];

      expect(() => input.splitByIndices(splitters), throwsA(isA<Exception>()));
    });

    test('should throw an exception if no splitters are provided', () {
      const input = "HelloWorld";
      final splitters = <int>[];

      expect(() => input.splitByIndices(splitters), throwsA(isA<Exception>()));
    });

    test('should throw an exception if any index is out of bounds', () {
      const input = "HelloWorld";
      final splitters = [100];
      expect(() => input.splitByIndices(splitters), throwsA(isA<RangeError>()));
    });

    test('should handle empty input string', () {
      const input = "";
      final splitters = [0];

      final result = input.splitByIndices(splitters);

      expect(result, []);
    });

    test('should correctly adjust splitters at the start and end', () {
      const input = "HelloWorld";
      final splitters = [3];

      final result = input.splitByIndices(splitters);

      expect(result, ['Hel', 'loWorld']);
    });

    test('should sort the splitters if they are out of order', () {
      const input = "HelloWorld";
      final splitters = [5, 1];

      final result = input.splitByIndices(splitters);

      expect(result, ['H', 'ello', 'World']);
    });
  });
}
