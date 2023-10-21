import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'kode_view_platform_interface.dart';

/// An implementation of [KodeViewPlatform] that uses method channels.
class MethodChannelKodeView extends KodeViewPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('kode_view');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
