import 'kode_view_platform_interface.dart';

export './src/presentation/code_text_view.dart' show CodeTextView;

class KodeView {
  Future<String?> getPlatformVersion() {
    return KodeViewPlatform.instance.getPlatformVersion();
  }
}
