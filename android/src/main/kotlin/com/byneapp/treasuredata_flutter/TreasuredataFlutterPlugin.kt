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

  private lateinit var td: TreasureData

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
          uploadEvents()
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

    TreasureData.initializeApiEndpoint("https://in.treasuredata.com")
    TreasureData.initializeSharedInstance(applicationContext, apiKey)
    TreasureData.initializeEncryptionKey(encryptionKey)

    call.argument<String>("dbName")?.let {
      TreasureData.sharedInstance().setDefaultDatabase(it)
    }

    call.argument<Boolean>("enableAppendUniqueId")?.let {
      if (it) {
        TreasureData.sharedInstance().enableAutoAppendUniqId()
      }
    }

    try {
      td = TreasureData(applicationContext)
      result.success(null)
    } catch (e: Exception) {
      result.error("Initialize Error", e.message, e.stackTrace)
    }
  }

  private  fun addEvents(call: MethodCall, result: Result) {
    val eventName = call.argument<String>("eventName")
    val events = call.argument<Map<String, Any>>("events")

    td.addEvent(eventName, events)

    result.success(null)
  }

  private fun uploadEvents() {
    td.uploadEvents()
  }
}
