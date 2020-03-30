import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class TreasuredataFlutter {
  static const MethodChannel _channel =
      const MethodChannel('treasuredata_flutter');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<void> initializeTreasureData(
      {@required String apiKey,
      @required String encryptionKey,
      @required String dbName,
      bool enableAppendUniqueId = false}) async {
    await _channel.invokeMethod('initTreasureData', {
      'apiKey': apiKey,
      'encryptionKey': encryptionKey,
      'dbName': dbName,
      'enableAppendUniqueId': enableAppendUniqueId
    });
  }

  static Future<void> addEvents(
      String eventName, Map<String, dynamic> events) async {
    await _channel
        .invokeMethod('addEvents', {'eventName': eventName, 'events': events});
  }

  static Future<void> uploadEvents() async =>
      await _channel.invokeMethod('uploadEvents');
}
