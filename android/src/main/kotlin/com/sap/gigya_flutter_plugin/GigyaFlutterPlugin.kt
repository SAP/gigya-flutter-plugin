package com.sap.gigya_flutter_plugin

import android.app.Application
import androidx.annotation.NonNull
import com.gigya.android.sdk.account.models.GigyaAccount
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** GigyaFlutterPlugin */
class GigyaFlutterPlugin : FlutterPlugin, MethodCallHandler {

    companion object {
        private lateinit var sdk: GigyaSDKWrapper<*>
        fun <T : GigyaAccount> init(application: Application, accountObj: Class<T>) {
            if (::sdk.isInitialized.not()) {
                sdk = GigyaSDKWrapper(application, accountObj)
            }
        }
    }


    /// Main communication method channel.
    private lateinit var channel: MethodChannel

    private var _messenger: BinaryMessenger? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        init(flutterPluginBinding.applicationContext as Application, GigyaAccount::class.java)
        _messenger = flutterPluginBinding.binaryMessenger
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "gigya_flutter_plugin")
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        _messenger = null
    }

    /// Main channel call handler. Will initiate native wrapper.
    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
            "sendRequest" -> sdk.sendRequest(call.arguments, result)
            "loginWithCredentials" -> sdk.loginWithCredentials(call.arguments, result)
            "registerWithCredentials" -> sdk.registerWithCredentials(call.arguments, result)
            "isLoggedIn" -> sdk.isLoggedIn(result)
            "getAccount" -> sdk.getAccount(call.arguments, result)
            "setAccount" -> sdk.setAccount(call.arguments, result)
            "logOut" -> sdk.logOut(result)
            "socialLogin" -> sdk.socialLogin(call.arguments, result)
            "addConnection" -> sdk.addConnection(call.arguments, result)
            "removeConnection" -> sdk.removeConnection(call.arguments, result)
            "showScreenSet" -> sdk.showScreenSet(call.arguments, result, _messenger)
            "getConflictingAccounts" -> sdk.resolveGetConflictingAccounts(result)
            "linkToSite" -> sdk.resolveLinkToSite(call.arguments, result)
            "linkToSocial" -> sdk.resolveLinkToSocial(call.arguments, result)
            "resolveSetAccount" -> sdk.resolveSetAccount(call.arguments, result)
            "forgotPassword" -> sdk.forgotPassword(call.arguments, result)
            "initSdk" -> sdk.initSdk(call.arguments, result)
            "setSession" -> sdk.setSession(call.arguments, result)
            "sso" -> sdk.sso(call.arguments, result)
            else -> result.notImplemented()
        }
    }


}
