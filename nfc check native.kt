package com.iconflux.utility

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import android.nfc.NfcAdapter
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "samples.flutter.dev/nfc"
    fun isNfcEnabled(): Boolean {
        val nfcAdapter = NfcAdapter.getDefaultAdapter(this)
        if (nfcAdapter != null) {
            return try {
                nfcAdapter.isEnabled
            } catch (exp: Exception) {
                // Double try this as there are times it will fail first time
                try {
                    nfcAdapter.isEnabled
                } catch (exp: Exception) {
                    false
                }
            }
        }
        return false
    }
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
      call, result ->
       if (call.method == "isNfcEnabled") {
     val nfcStatus = isNfcEnabled()

    if (nfcStatus != null) {
      result.success(nfcStatus)
    } else {
      result.success(false)
    }
  } else {
    result.notImplemented()
    }
    }
    }
   
}
  
