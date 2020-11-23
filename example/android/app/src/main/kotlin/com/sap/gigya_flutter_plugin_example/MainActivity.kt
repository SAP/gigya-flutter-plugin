package com.sap.gigya_flutter_plugin_example

import com.gigya.android.sdk.account.models.GigyaAccount
import com.sap.gigya_flutter_plugin.GigyaFlutterPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        // Copy this code to you Android app.
        //
        // Reference the plugin and register your SDK initialization parameters.
        val plugin: GigyaFlutterPlugin= flutterEngine.plugins.get(GigyaFlutterPlugin::class.java) as GigyaFlutterPlugin
        plugin.registerWith(application, GigyaAccount::class.java)
    }
}
