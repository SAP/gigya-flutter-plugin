package com.sap.gigya_flutter_plugin

import android.app.Application
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import com.gigya.android.sdk.*
import com.gigya.android.sdk.account.models.GigyaAccount
import com.gigya.android.sdk.api.GigyaApiRequestFactory
import com.gigya.android.sdk.api.GigyaApiResponse
import com.gigya.android.sdk.api.IApiRequestFactory
import com.gigya.android.sdk.network.GigyaError
import com.gigya.android.sdk.ui.plugin.GigyaPluginEvent
import com.gigya.android.sdk.utils.CustomGSONDeserializer
import com.google.gson.GsonBuilder
import com.google.gson.reflect.TypeToken
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class GigyaSDKWrapper<T : GigyaAccount>(application: Application, accountObj: Class<T>) {

    private var sdk: Gigya<T>

    val gson = GsonBuilder().registerTypeAdapter(object : TypeToken<Map<String?, Any?>?>() {}.type, CustomGSONDeserializer()).create()

    init {
        Gigya.setApplication(application)
        sdk = Gigya.getInstance(accountObj)

        try {
            val pInfo: PackageInfo = application.packageManager.getPackageInfo(application.packageName, 0)
            val version: String = pInfo.versionName
            val ref:IApiRequestFactory  = Gigya.getContainer().get(IApiRequestFactory::class.java)
            ref.setSDK("Flutter_${version}")
        } catch (e: PackageManager.NameNotFoundException) {
            e.printStackTrace()
        }
    }

    /**
     * Send general/antonymous request.
     */
    fun sendRequest(arguments: Any, channelResult: MethodChannel.Result) {
        val endpoint: String? = (arguments as Map<*, *>)["endpoint"] as String?
        if (endpoint == null) {
            channelResult.error(MISSING_PARAMETER_ERROR, MISSING_PARAMETER_MESSAGE, mapOf<String, Any>())
            return
        }
        val parameters: Map<String, Any>? = arguments["parameters"] as Map<String, Any>?
        if (parameters == null) {
            channelResult.error(MISSING_PARAMETER_ERROR, MISSING_PARAMETER_MESSAGE, mapOf<String, Any>())
            return
        }
        sdk.send(endpoint, parameters, object : GigyaCallback<GigyaApiResponse>() {
            override fun onSuccess(p0: GigyaApiResponse?) {
                p0?.let {
                    channelResult.success(it.asJson())
                } ?: channelResult.notImplemented()
            }

            override fun onError(p0: GigyaError?) {
                p0?.let {
                    channelResult.error(p0.errorCode.toString(), p0.localizedMessage, p0.data)
                } ?: channelResult.notImplemented()
            }

        })
    }

    /**
     * Login using credentials (loginId/password combination with optional parameter map).
     */
    fun loginWithCredentials(arguments: Any, channelResult: MethodChannel.Result) {
        val loginId: String? = (arguments as Map<*, *>)["loginId"] as String?
        if (loginId == null) {
            channelResult.error(MISSING_PARAMETER_ERROR, MISSING_PARAMETER_MESSAGE, mapOf<String, Any>())
            return
        }
        val password: String? = arguments["password"] as String?
        if (password == null) {
            channelResult.error(MISSING_PARAMETER_ERROR, MISSING_PARAMETER_MESSAGE, mapOf<String, Any>())
            return
        }
        val parameters: Map<String, Any>? = arguments["parameters"] as Map<String, Any>?
        val loginParams = mutableMapOf<String, Any>("loginID" to loginId, "password" to password)
        if (parameters != null) {
            loginParams.putAll(parameters)
        }
        sdk.login(loginParams, object : GigyaLoginCallback<T>() {

            override fun onSuccess(p0: T) {
                val mapped = mapAccountObject(p0)
                channelResult.success(mapped)
            }

            override fun onError(p0: GigyaError?) {
                p0?.let {
                    channelResult.error(p0.errorCode.toString(), p0.localizedMessage, p0.data)
                } ?: channelResult.notImplemented()
            }

        })
    }

    /**
     * Register a new user using credentials (email/password combination with optional parameter map).
     */
    fun registerWithCredentials(arguments: Any, channelResult: MethodChannel.Result) {
        val email: String? = (arguments as Map<*, *>)["email"] as String?
        if (email == null) {
            channelResult.error(MISSING_PARAMETER_ERROR, MISSING_PARAMETER_MESSAGE, mapOf<String, Any>())
            return
        }
        val password: String? = arguments["password"] as String?
        if (password == null) {
            channelResult.error(MISSING_PARAMETER_ERROR, MISSING_PARAMETER_MESSAGE, mapOf<String, Any>())
            return
        }
        val parameters: MutableMap<String, Any> = arguments["parameters"] as MutableMap<String, Any>?
                ?: mutableMapOf()
        sdk.register(email, password, parameters!!, object : GigyaLoginCallback<T>() {
            override fun onSuccess(p0: T) {
                val mapped = mapAccountObject(p0)
                channelResult.success(mapped)
            }

            override fun onError(p0: GigyaError?) {
                p0?.let {
                    channelResult.error(p0.errorCode.toString(), p0.localizedMessage, p0.data)
                } ?: channelResult.notImplemented()
            }

        })
    }

    /**
     * Check login status.
     */
    fun isLoggedIn(channelResult: MethodChannel.Result) {
        val loginState = sdk.isLoggedIn
        channelResult.success(loginState)
    }

    /**
     * Request active account.
     */
    fun getAccount(arguments: Any, channelResult: MethodChannel.Result) {
        val invalidate: Boolean = (arguments as Map<*, *>)["invalidate"] as Boolean? ?: false
        sdk.getAccount(invalidate, object : GigyaCallback<T>() {
            override fun onSuccess(p0: T) {
                val mapped = mapAccountObject(p0)
                channelResult.success(mapped)
            }

            override fun onError(p0: GigyaError?) {
                p0?.let {
                    channelResult.error(p0.errorCode.toString(), p0.localizedMessage, p0.data)
                } ?: channelResult.notImplemented()
            }

        })
    }

    /**
     * Update account information
     */
    fun setAccount(arguments: Any, channelResult: MethodChannel.Result) {
        val account: MutableMap<String, Any>? = (arguments as Map<*, *>)["account"] as MutableMap<String, Any>?
        if (account == null) {
            channelResult.error(MISSING_PARAMETER_ERROR, MISSING_PARAMETER_MESSAGE, mapOf<String, Any>())
            return
        }
        sdk.setAccount(account, object : GigyaCallback<T>() {
            override fun onSuccess(p0: T) {
                val mapped = mapAccountObject(p0)
                channelResult.success(mapped)
            }

            override fun onError(p0: GigyaError?) {
                p0?.let {
                    channelResult.error(p0.errorCode.toString(), p0.localizedMessage, p0.data)
                } ?: channelResult.notImplemented()
            }

        })
    }

    /**
     * Logout of existing session.
     */
    fun logOut(channelResult: MethodChannel.Result) {
        sdk.logout(object : GigyaCallback<GigyaApiResponse>() {
            override fun onSuccess(p0: GigyaApiResponse?) {
                channelResult.success(null)
            }

            override fun onError(p0: GigyaError?) {
                p0?.let {
                    channelResult.error(p0.errorCode.toString(), p0.localizedMessage, p0.data)
                } ?: channelResult.notImplemented()
            }

        });
    }

    /**
     * Social login with given provider & provider sessions.
     */
    fun socialLogin(arguments: Any, channelResult: MethodChannel.Result) {
        val provider: String? = (arguments as Map<*, *>)["provider"] as String?
        if (provider == null) {
            channelResult.error(MISSING_PARAMETER_ERROR, MISSING_PARAMETER_MESSAGE, mapOf<String, Any>())
            return
        }
        val parameters: MutableMap<String, Any> = arguments["parameters"] as MutableMap<String, Any>?
                ?: mutableMapOf()
        sdk.login(provider, parameters, object : GigyaLoginCallback<T>() {
            override fun onSuccess(p0: T) {
                val mapped = mapAccountObject(p0)
                channelResult.success(mapped)
            }

            override fun onError(p0: GigyaError?) {
                p0?.let {
                    channelResult.error(p0.errorCode.toString(), p0.localizedMessage, p0.data)
                } ?: channelResult.notImplemented()
            }

            override fun onOperationCanceled() {
                channelResult.error(CANCELED_ERROR, CANCELED_ERROR_MESSAGE, null)
            }

        })
    }

    /**
     * Add social connection to active session.
     */
    fun addConnection(arguments: Any, channelResult: MethodChannel.Result) {
        val provider: String? = (arguments as Map<*, *>)["provider"] as String?
        if (provider == null) {
            channelResult.error(MISSING_PARAMETER_ERROR, MISSING_PARAMETER_MESSAGE, mapOf<String, Any>())
            return
        }
        sdk.addConnection(provider, object : GigyaLoginCallback<T>() {
            override fun onSuccess(p0: T) {
                val mapped = mapAccountObject(p0)
                channelResult.success(mapped)
            }

            override fun onError(p0: GigyaError?) {
                p0?.let {
                    channelResult.error(p0.errorCode.toString(), p0.localizedMessage, p0.data)
                } ?: channelResult.notImplemented()
            }

            override fun onOperationCanceled() {
                channelResult.error(CANCELED_ERROR, CANCELED_ERROR_MESSAGE, null)
            }

        })
    }

    /**
     * Remove social connection.
     */
    fun removeConnection(arguments: Any, channelResult: MethodChannel.Result) {
        val provider: String? = (arguments as Map<*, *>)["provider"] as String?
        if (provider == null) {
            channelResult.error(MISSING_PARAMETER_ERROR, MISSING_PARAMETER_MESSAGE, mapOf<String, Any>())
            return
        }
        sdk.removeConnection(provider, object : GigyaCallback<GigyaApiResponse>() {
            override fun onSuccess(p0: GigyaApiResponse?) {
                p0?.let {
                    val mapped = gson.fromJson<Map<String, Any>>(it.asJson(), object : TypeToken<Map<String, Any>>() {}.type)
                    channelResult.success(mapped)
                } ?: channelResult.notImplemented()
            }

            override fun onError(p0: GigyaError?) {
                p0?.let {
                    channelResult.error(p0.errorCode.toString(), p0.localizedMessage, p0.data)
                } ?: channelResult.notImplemented()
            }

        })
    }

    private var screenSetsEventsSink: EventChannel.EventSink? = null
    private var screenSetEventsChannel: EventChannel? = null
    private var screenSetsEventsHandler: EventChannel.StreamHandler? = null;

    /**
     * Trigger embedded web screen sets.
     */
    fun showScreenSet(arguments: Any, channelResult: MethodChannel.Result, messenger: BinaryMessenger?) {
        if (messenger == null) {
            channelResult.error(GENERAL_ERROR, GENERAL_ERROR_MESSAGE, mapOf<String, Any>())
            return
        }
        val screenSet: String? = (arguments as Map<*, *>)["screenSet"] as String?
        if (screenSet == null) {
            channelResult.error(MISSING_PARAMETER_ERROR, MISSING_PARAMETER_MESSAGE, mapOf<String, Any>())
            return
        }
        val parameters: MutableMap<String, Any> = arguments["parameters"] as MutableMap<String, Any>?
                ?: mutableMapOf()

        // Set events channel & handler.
        screenSetEventsChannel = EventChannel(messenger, "screensetEvents")
        screenSetsEventsHandler = object : EventChannel.StreamHandler {
            override fun onListen(p0: Any?, sink: EventChannel.EventSink?) {
                screenSetsEventsSink = sink
            }

            override fun onCancel(p0: Any?) {
                screenSetEventsChannel = null
            }
        }
        screenSetEventsChannel!!.setStreamHandler(screenSetsEventsHandler)

        sdk.showScreenSet(screenSet, true, parameters, object : GigyaPluginCallback<T>() {
            override fun onError(event: GigyaPluginEvent?) {
                screenSetsEventsSink?.success(mapOf("event" to "onError", "data" to event!!.eventMap))
            }

            override fun onCanceled() {
                screenSetsEventsSink?.error("200001", "Operation canceled", null)
                screenSetsEventsHandler = null
                screenSetEventsChannel = null
                screenSetsEventsSink = null
            }

            override fun onHide(event: GigyaPluginEvent, reason: String?) {
                screenSetsEventsSink?.success(mapOf("event" to "onHide", "reason" to reason!!, "data" to event.eventMap))
                screenSetsEventsHandler = null
                screenSetEventsChannel = null
                screenSetsEventsSink = null
            }

            override fun onLogin(accountObj: T) {
                screenSetsEventsSink?.success(mapOf("event" to "onLogin", "data" to mapAccountObject(accountObj)))
            }

            override fun onLogout() {
                screenSetsEventsSink?.success(mapOf("event" to "onLogout"))
            }

            override fun onConnectionAdded() {
                screenSetsEventsSink?.success(mapOf("event" to "onConnectionAdded"))
            }

            override fun onConnectionRemoved() {
                screenSetsEventsSink?.success(mapOf("event" to "onConnectionRemoved"))
            }

            override fun onBeforeScreenLoad(event: GigyaPluginEvent) {
                screenSetsEventsSink?.success(mapOf("event" to "onBeforeScreenLoad", "data" to event.eventMap))
            }

            override fun onAfterScreenLoad(event: GigyaPluginEvent) {
                screenSetsEventsSink?.success(mapOf("event" to "onAfterScreenLoad", "data" to event.eventMap))
            }

            override fun onBeforeValidation(event: GigyaPluginEvent) {
                screenSetsEventsSink?.success(mapOf("event" to "onBeforeValidation", "data" to event.eventMap))
            }

            override fun onAfterValidation(event: GigyaPluginEvent) {
                screenSetsEventsSink?.success(mapOf("event" to "onAfterValidation", "data" to event.eventMap))
            }

            override fun onBeforeSubmit(event: GigyaPluginEvent) {
                screenSetsEventsSink?.success(mapOf("event" to "onBeforeSubmit", "data" to event.eventMap))
            }

            override fun onSubmit(event: GigyaPluginEvent) {
                screenSetsEventsSink?.success(mapOf("event" to "onSubmit", "data" to event.eventMap))
            }

            override fun onAfterSubmit(event: GigyaPluginEvent) {
                screenSetsEventsSink?.success(mapOf("event" to "onAfterSubmit", "data" to event.eventMap))
            }

            override fun onFieldChanged(event: GigyaPluginEvent) {
                screenSetsEventsSink?.success(mapOf("event" to "onFieldChanged", "data" to event.eventMap))
            }
        })

        // Return void result. Streaming channel will handled plugin events.
        channelResult.success(null)
    }


    /**
     * Map typed account object to a Map<String, Any> object in order to pass on to
     * the method channel response.
     */
    private fun mapAccountObject(account: T): Map<String, Any> {
        val jsonString = gson.toJson(account)
        return gson.fromJson(jsonString, object : TypeToken<Map<String, Any>>() {}.type)
    }

    companion object {

        const val GENERAL_ERROR = "700"
        const val GENERAL_ERROR_MESSAGE = "general error"
        const val MISSING_PARAMETER_ERROR = "701"
        const val MISSING_PARAMETER_MESSAGE = "request parameter missing"
        const val CANCELED_ERROR = "702"
        const val CANCELED_ERROR_MESSAGE = "Operation canceled"
    }

}