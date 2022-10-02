package com.sap.gigya_flutter_plugin_example

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.IntentSenderRequest
import androidx.activity.result.contract.ActivityResultContracts
import com.gigya.android.sdk.Gigya
import com.sap.gigya_flutter_plugin.GigyaFlutterPlugin
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {

    // Custom result handler for FIDO sender intents.
    private val resultHandler: ActivityResultLauncher<IntentSenderRequest> =
        (activity as ComponentActivity).registerForActivityResult(
            ActivityResultContracts.StartIntentSenderForResult()
        ) { activityResult ->
            val extras =
                activityResult.data?.extras?.keySet()?.map { "$it: ${intent.extras?.get(it)}" }
                    ?.joinToString { it }
            Gigya.getInstance().WebAuthn().handleFidoResult(activityResult)
        }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val plugin = flutterEngine?.plugins?.get(GigyaFlutterPlugin::class.java)
        plugin?.let { gigyaFlutterPlugin ->
            (gigyaFlutterPlugin as GigyaFlutterPlugin).fidoResultHandler = resultHandler
        }
    }
}