import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kode_view/kode_view_method_channel.dart';

void main() {
  MethodChannelKodeView platform = MethodChannelKodeView();
  const MethodChannel channel = MethodChannel('kode_view');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
