https://github.com/transistorsoft/flutter_background_fetch/blob/master/help/INSTALL-ANDROID.md
package com.example.localnoti

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import com.transistorsoft.flutter.backgroundfetch.BackgroundFetchPlugin;
import io.flutter.embedding.engine.FlutterEngine

import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.GeneratedPluginRegistrant


class MainActivity2: FlutterActivity() ,PluginRegistry.PluginRegistrantCallback  {
    fun onCreate(){
        BackgroundFetchPlugin.setPluginRegistrant(this);

    }
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }
//     override fun registerWith(registry: PluginRegistry) {
//        GeneratedPluginRegistrant.registerWith(this.flutterEngine);
//    }
    override fun registerWith(registry: PluginRegistry?) {
        registry?.registrarFor("com.transistorsoft.flutter.backgroundfetch.BackgroundFetchPlugin");
    }
}
