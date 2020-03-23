import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:treasuredata_flutter/treasuredata_flutter.dart';

void main() {
  const MethodChannel channel = MethodChannel('treasuredata_flutter');

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
    expect(await TreasuredataFlutter.platformVersion, '42');
  });
}
