import Flutter
import UIKit

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
    case "addEvents":
        addEvents()
    case "uploadEvents":
        uploadEvents()
    default:
        result(FlutterMethodNotImplemented)
    }
  }
    
    private func initTreasureData(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let arguments = call.arguments as! Dictionary<String, AnyObject>
        
        // TODO
    }
    
    private func addEvents() {
        // TODO
    }
    
    private func uploadEvents() {
        // TODO
    }
    
    
}
