package com.example.link_in_bio

import android.provider.Settings
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "link_in_bio/android_id"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            if (call.method == "getAndroidId"){
                val androidId : String = Settings.Secure.getString(this.contentResolver, Settings.Secure.ANDROID_ID);
                if (!androidId.isNullOrEmpty()){
                    result.success(androidId);
                } else {
                    result.error("UNAVAILABLE", "Android ID is unavailable", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}