package com.byneapp.treasuredata_flutter

import android.content.Context
import android.content.Intent
import android.content.res.Configuration
import android.os.Bundle
import androidx.annotation.NonNull;
import com.treasuredata.android.TreasureData
import io.flutter.app.FlutterActivityEvents

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/** TreasuredataFlutterPlugin */
public class TreasuredataFlutterPlugin(private val context: Context? = null): FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private var applicationContext: Context? = context

  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    applicationContext = flutterPluginBinding.applicationContext
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "treasuredata_flutter")
    channel.setMethodCallHandler(this)
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "treasuredata_flutter")
      channel.setMethodCallHandler(TreasuredataFlutterPlugin(registrar.context()))
    }
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    when (call.method) {
        "initTreasureData" -> {
          initTreasureData(call, result)
        }
        "addEvents" -> {
          addEvents(call, result)
        }
        "uploadEvents" -> {
          uploadEvents(call, result)
        }
        else -> {
          result.notImplemented()
        }
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
    applicationContext = null
  }

  private fun initTreasureData(call: MethodCall, result: Result) {
    val apiKey = call.argument<String>("apiKey")
    val encryptionKey = call.argument<String>("encryptionKey")
    val apiEndpoint = call.argument<String>("apiEndpoint")

    // "https://in.treasuredata.com"
    TreasureData.initializeApiEndpoint(apiEndpoint)
    TreasureData.initializeSharedInstance(applicationContext, apiKey)
    TreasureData.initializeEncryptionKey(encryptionKey)

    call.argument<String>("dbName")?.let {
      TreasureData.sharedInstance().setDefaultDatabase(it)
    }

    call.argument<Boolean>("enableLogging")?.let {
      if (it) {
        TreasureData.enableLogging()
      } else {
        TreasureData.disableLogging()
      }
    }

    call.argument<Boolean>("enableAppendUniqueId")?.let {
      if (it) {
        TreasureData.sharedInstance().enableAutoAppendUniqId()
      }
    }

    call.argument<Boolean>("enableAppendAdvertisingIdentifier")?.let {
      if (it) {
        TreasureData.sharedInstance().enableAutoAppendAdvertisingIdentifier()
      }
    }

    call.argument<Boolean>("enableAutoAppendModelInformation")?.let {
      if (it) {
        TreasureData.sharedInstance().enableAutoAppendModelInformation()
      }
    }

    call.argument<Boolean>("enableAutoAppendAppInformation")?.let {
      if (it) {
        TreasureData.sharedInstance().enableAutoAppendAppInformation()
      }
    }

    call.argument<Boolean>("enableAutoAppendLocaleInformation")?.let {
      if (it) {
        TreasureData.sharedInstance().enableAutoAppendLocaleInformation()
      }
    }

    call.argument<Boolean>("enableCustomEvent")?.let {
      if (it) {
        TreasureData.sharedInstance().enableCustomEvent()
      }
    }

    call.argument<Boolean>("enableAppLifecycleEvent")?.let {
      if (it) {
        TreasureData.sharedInstance().enableAppLifecycleEvent()
      }
    }

    call.argument<Boolean>("enableInAppPurchaseEvent")?.let {
      if (it) {
        TreasureData.sharedInstance().enableInAppPurchaseEvent()
      }
    }

    result.success(null)
  }

  private fun addEvents(call: MethodCall, result: Result) {
    val database = call.argument<String>("database")
    val table = call.argument<String>("table")
    val events = call.argument<Map<String, Any>>("events")

    if (database != null) {
      TreasureData.sharedInstance().addEvent(database, table, events)
    }else{
      TreasureData.sharedInstance().addEvent(table, events)
    }


    result.success(null)
  }

  private fun uploadEvents(call: MethodCall, result: Result) {
    TreasureData.sharedInstance().uploadEvents()
    result.success(null)
  }
}
