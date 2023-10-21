import 'package:flutter_test/flutter_test.dart';
import 'package:kode_view/kode_view.dart';
import 'package:kode_view/kode_view_platform_interface.dart';
import 'package:kode_view/kode_view_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockKodeViewPlatform
    with MockPlatformInterfaceMixin
    implements KodeViewPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final KodeViewPlatform initialPlatform = KodeViewPlatform.instance;

  test('$MethodChannelKodeView is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelKodeView>());
  });

  test('getPlatformVersion', () async {
    KodeView kodeViewPlugin = KodeView();
    MockKodeViewPlatform fakePlatform = MockKodeViewPlatform();
    KodeViewPlatform.instance = fakePlatform;

    expect(await kodeViewPlugin.getPlatformVersion(), '42');
  });
}
