import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'kode_view_method_channel.dart';

abstract class KodeViewPlatform extends PlatformInterface {
  /// Constructs a KodeViewPlatform.
  KodeViewPlatform() : super(token: _token);

  static final Object _token = Object();

  static KodeViewPlatform _instance = MethodChannelKodeView();

  /// The default instance of [KodeViewPlatform] to use.
  ///
  /// Defaults to [MethodChannelKodeView].
  static KodeViewPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [KodeViewPlatform] when
  /// they register themselves.
  static set instance(KodeViewPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
