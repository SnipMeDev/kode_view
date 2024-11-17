import 'package:highlights_plugin/highlights_plugin.dart';

export './src/presentation/code_edit_text.dart' show CodeEditText;
export './src/presentation/code_text_view.dart' show CodeTextView;
export './src/presentation/text_selection_options.dart'
    show TextSelectionOptions;

class KodeView {
  static Future<List<String>> getLanguages() async =>
      await HighlightsPlugin().getLanguages();
  static Future<List<String>> getThemes() async =>
      await HighlightsPlugin().getThemes();
}
