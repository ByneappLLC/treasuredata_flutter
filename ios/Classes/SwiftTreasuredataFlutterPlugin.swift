import Flutter
import UIKit
import TreasureData_iOS_SDK

public class SwiftTreasuredataFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "treasuredata_flutter", binaryMessenger: registrar.messenger())
    let instance = SwiftTreasuredataFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "initTreasureData":
        initTreasureData(call, result: result)
        break;
        
    case "addEvents":
        addEvents(call, result: result)
        break;
        
    case "uploadEvents":
        uploadEvents(call, result: result)
        break;
        
    default:
        result(FlutterMethodNotImplemented)
    }
  }
    
    private func uploadEvents(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        TreasureData.sharedInstance().uploadEvents()
        result(nil)
    }
    
    private func addEvents(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let myArgs = call.arguments as? [String: Any],
            let database = myArgs["database"] as? String,
            let table = myArgs["table"] as? String,
            let events = myArgs["events"] as? [String: Any] else {
                
            result(FlutterMethodNotImplemented)
            return
        }
        
        TreasureData.sharedInstance().addEvent(events, database: database, table: table)
        result(nil)
    }
    
    private func initTreasureData(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let myArgs = call.arguments as? [String: Any],
            let apiKey = myArgs["apiKey"] as? String,
            let encryptionKey = myArgs["encryptionKey"] as? String,
            let apiEndpoint = myArgs["apiEndpoint"] as? String,
            let dbName = myArgs["dbName"] as? String,
            let enableLogging = myArgs["enableLogging"] as? Bool,
            let enableAppendUniqueId = myArgs["enableAppendUniqueId"] as? Bool,
            let enableAppendAdvertisingIdentifier = myArgs["enableAppendAdvertisingIdentifier"] as? Bool,
            let enableAutoAppendModelInformation = myArgs["enableAutoAppendModelInformation"] as? Bool,
            let enableAutoAppendAppInformation = myArgs["enableAutoAppendAppInformation"] as? Bool,
            let enableAutoAppendLocaleInformation = myArgs["enableAutoAppendLocaleInformation"] as? Bool,
            let enableCustomEvent = myArgs["enableCustomEvent"] as? Bool,
            let enableAppLifecycleEvent = myArgs["enableAppLifecycleEvent"] as? Bool,
            let enableInAppPurchaseEvent = myArgs["enableInAppPurchaseEvent"] as? Bool else {
                result(FlutterMethodNotImplemented)
                return
        }
        
        TreasureData.initialize(withApiKey: apiKey)
        TreasureData.initializeEncryptionKey(encryptionKey)
        TreasureData.initializeApiEndpoint(apiEndpoint)
        TreasureData.sharedInstance().defaultDatabase = dbName
        
        if enableLogging {
            TreasureData.enableLogging()
        }else{
            TreasureData.disableLogging()
        }
        
        if enableAppendUniqueId {
            TreasureData.sharedInstance().enableAutoAppendUniqId()
        }
        if enableAppendAdvertisingIdentifier {
            TreasureData.sharedInstance().enableAutoAppendAdvertisingIdentifier()
        }
        if enableAutoAppendModelInformation {
            TreasureData.sharedInstance().enableAutoAppendModelInformation()
        }
        if enableAutoAppendAppInformation {
            TreasureData.sharedInstance().enableAutoAppendAppInformation()
        }
        if enableAutoAppendLocaleInformation {
            TreasureData.sharedInstance().enableAutoAppendLocaleInformation()
        }
        if enableCustomEvent {
            TreasureData.sharedInstance().enableCustomEvent()
        }
        if enableAppLifecycleEvent {
            TreasureData.sharedInstance().enableAppLifecycleEvent()
        }
        if enableInAppPurchaseEvent {
            TreasureData.sharedInstance().enableInAppPurchaseEvent()
        }
        
        result(nil)
    }
}
