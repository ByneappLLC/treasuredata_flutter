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

  static Future<void> initializeTreasureData({
    @required String apiKey,
    @required String encryptionKey,
    @required String apiEndpoint,
    @required String dbName,
    bool enableLogging = false,
    bool enableAppendUniqueId = true,
    bool enableAppendAdvertisingIdentifier = true,
    bool enableAutoAppendModelInformation = true,
    bool enableAutoAppendAppInformation = true,
    bool enableAutoAppendLocaleInformation = true,
    bool enableCustomEvent = true,
    bool enableAppLifecycleEvent = true,
    bool enableInAppPurchaseEvent = true,
  }) async {
    await _channel.invokeMethod('initTreasureData', {
      'apiKey': apiKey,
      'encryptionKey': encryptionKey,
      'apiEndpoint': apiEndpoint,
      'dbName': dbName,
      'enableLogging': enableLogging,
      'enableAppendUniqueId': enableAppendUniqueId,
      'enableAppendAdvertisingIdentifier': enableAppendAdvertisingIdentifier,
      'enableAutoAppendModelInformation': enableAutoAppendModelInformation,
      'enableAutoAppendAppInformation': enableAutoAppendAppInformation,
      'enableAutoAppendLocaleInformation': enableAutoAppendLocaleInformation,
      'enableCustomEvent': enableCustomEvent,
      'enableAppLifecycleEvent': enableAppLifecycleEvent,
      'enableInAppPurchaseEvent': enableInAppPurchaseEvent,
    });
  }

  static Future<void> addEvents(
      {@required String table,
      @required Map<String, dynamic> events,
      String database}) async {
    await _channel.invokeMethod(
        'addEvents', {'table': table, 'database': database, 'events': events});
  }

  static Future<void> uploadEvents() async =>
      await _channel.invokeMethod('uploadEvents');
}
