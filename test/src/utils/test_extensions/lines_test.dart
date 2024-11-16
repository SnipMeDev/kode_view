import 'package:flutter_test/flutter_test.dart';
import 'package:kode_view/src/utils/extensions/text_extensions.dart';

void main() {
  group('lines method tests', () {
    const multiLineCodeSample =
        "class HelloWorld {\n\tpublic static void main(String[] args) {\n\t\tSystem.out.println(\"Hello, World!\"); \n}}";

    test('Extracts correct parts of a multiline string', () {
      expect(multiLineCodeSample.lines(0), '');
      expect(multiLineCodeSample.lines(1), 'class HelloWorld {');
      expect(
        multiLineCodeSample.lines(2),
        'class HelloWorld {\n\tpublic static void main(String[] args) {',
      );
    });

    test('Handles out-of-bounds indices', () {
      expect(() => multiLineCodeSample.lines(-1), throwsA(isA<RangeError>()));
      expect(multiLineCodeSample.lines(10), multiLineCodeSample.lines(4));
    });

    test('Handles empty string', () {
      var emptyText = '';
      expect(emptyText.lines(0), '');
      expect(emptyText.lines(1), '');
    });
  });
}
