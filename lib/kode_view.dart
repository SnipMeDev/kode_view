
import 'kode_view_platform_interface.dart';

class KodeView {
  Future<String?> getPlatformVersion() {
    return KodeViewPlatform.instance.getPlatformVersion();
  }
}
