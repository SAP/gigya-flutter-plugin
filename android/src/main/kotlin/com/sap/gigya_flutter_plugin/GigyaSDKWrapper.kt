package com.sap.gigya_flutter_plugin

import android.app.Application
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import com.gigya.android.sdk.*
import com.gigya.android.sdk.account.models.GigyaAccount
import com.gigya.android.sdk.api.GigyaApiResponse
import com.gigya.android.sdk.api.IApiRequestFactory
import com.gigya.android.sdk.interruption.IPendingRegistrationResolver
import com.gigya.android.sdk.interruption.link.ILinkAccountsResolver
import com.gigya.android.sdk.network.GigyaError
import com.gigya.android.sdk.ui.plugin.GigyaPluginEvent
import com.gigya.android.sdk.utils.CustomGSONDeserializer
import com.google.gson.GsonBuilder
import com.google.gson.reflect.TypeToken
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import java.util.*

class GigyaSDKWrapper<T : GigyaAccount>(application: Application, accountObj: Class<T>) {

    private var sdk: Gigya<T>

    private var resolverHelper: ResolverHelper = ResolverHelper()

    private var currentResult: MethodChannel.Result? = null

    private val gson = GsonBuilder().registerTypeAdapter(object : TypeToken<Map<String?, Any?>?>() {}.type, CustomGSONDeserializer()).create()

    init {
        Gigya.setApplication(application)
        sdk = Gigya.getInstance(accountObj)

        try {
            val pInfo: PackageInfo = application.packageManager.getPackageInfo(application.packageName, 0)
            val version: String = pInfo.versionName
            val ref: IApiRequestFactory = Gigya.getContainer().get(IApiRequestFactory::class.java)
            ref.setSDK("flutter_${version}_android_${(Gigya.VERSION).toLowerCase(Locale.ENGLISH)}")
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
                    channelResult.error(p0.errorCode.toString(), p0.localizedMessage, mapJson(p0.data))
                } ?: channelResult.notImplemented()
            }

        })
    }

    /**
     * Login using credentials (loginId/password combination with optional parameter map).
     */
    fun loginWithCredentials(arguments: Any, channelResult: MethodChannel.Result) {
        currentResult = channelResult
        val loginId: String? = (arguments as Map<*, *>)["loginId"] as String?
        if (loginId == null) {
            currentResult!!.error(MISSING_PARAMETER_ERROR, MISSING_PARAMETER_MESSAGE, mapOf<String, Any>())
            return
        }
        val password: String? = arguments["password"] as String?
        if (password == null) {
            currentResult!!.error(MISSING_PARAMETER_ERROR, MISSING_PARAMETER_MESSAGE, mapOf<String, Any>())
            return
        }
        val parameters: Map<String, Any>? = arguments["parameters"] as Map<String, Any>?
        val loginParams = mutableMapOf<String, Any>("loginID" to loginId, "password" to password)
        if (parameters != null) {
            loginParams.putAll(parameters)
        }
        sdk.login(loginParams, object : GigyaLoginCallback<T>() {

            override fun onSuccess(p0: T) {
                resolverHelper.clear()
                val mapped = mapObject(p0)
                currentResult!!.success(mapped)
            }

            override fun onError(p0: GigyaError?) {
                p0?.let {
                    currentResult!!.error(p0.errorCode.toString(), p0.localizedMessage, mapJson(p0.data))
                } ?: currentResult!!.notImplemented()
            }

            override fun onConflictingAccounts(response: GigyaApiResponse, resolver: ILinkAccountsResolver) {
                resolverHelper.linkAccountResolver = resolver
                currentResult!!.error(response.errorCode.toString(), response.errorDetails, response.asMap())
            }

            override fun onPendingRegistration(response: GigyaApiResponse, resolver: IPendingRegistrationResolver) {
                resolverHelper.pendingRegistrationResolver = resolver
                currentResult!!.error(response.errorCode.toString(), response.errorDetails, response.asMap())
            }

            override fun onPendingVerification(response: GigyaApiResponse, regToken: String?) {
                resolverHelper.regToken = regToken
                currentResult!!.error(response.errorCode.toString(), response.errorDetails, response.asMap())
            }
        })
    }

    /**
     * Register a new user using credentials (email/password combination with optional parameter map).
     */
    fun registerWithCredentials(arguments: Any, channelResult: MethodChannel.Result) {
        currentResult = channelResult;
        val email: String? = (arguments as Map<*, *>)["email"] as String?
        if (email == null) {
            currentResult!!.error(MISSING_PARAMETER_ERROR, MISSING_PARAMETER_MESSAGE, mapOf<String, Any>())
            return
        }
        val password: String? = arguments["password"] as String?
        if (password == null) {
            currentResult!!.error(MISSING_PARAMETER_ERROR, MISSING_PARAMETER_MESSAGE, mapOf<String, Any>())
            return
        }
        val parameters: MutableMap<String, Any> = arguments["parameters"] as MutableMap<String, Any>?
                ?: mutableMapOf()
        sdk.register(email, password, parameters!!, object : GigyaLoginCallback<T>() {
            override fun onSuccess(p0: T) {
                resolverHelper.clear()
                val mapped = mapObject(p0)
                currentResult!!.success(mapped)
            }

            override fun onError(p0: GigyaError?) {
                p0?.let {
                    currentResult!!.error(p0.errorCode.toString(), p0.localizedMessage, mapJson(p0.data))
                } ?: currentResult!!.notImplemented()
            }

            override fun onConflictingAccounts(response: GigyaApiResponse, resolver: ILinkAccountsResolver) {
                resolverHelper.linkAccountResolver = resolver
                currentResult!!.error(response.errorCode.toString(), response.errorDetails, response.asMap())
            }

            override fun onPendingRegistration(response: GigyaApiResponse, resolver: IPendingRegistrationResolver) {
                resolverHelper.pendingRegistrationResolver = resolver
                currentResult!!.error(response.errorCode.toString(), response.errorDetails, response.asMap())
            }

            override fun onPendingVerification(response: GigyaApiResponse, regToken: String?) {
                resolverHelper.regToken = regToken
                currentResult!!.error(response.errorCode.toString(), response.errorDetails, response.asMap())
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
        val parameters: MutableMap<String, Any> = arguments["parameters"] as MutableMap<String, Any>?
                ?: mutableMapOf()
        sdk.getAccount(invalidate, parameters, object : GigyaCallback<T>() {
            override fun onSuccess(p0: T) {
                val mapped = mapObject(p0)
                channelResult.success(mapped)
            }

            override fun onError(p0: GigyaError?) {
                p0?.let {
                    channelResult.error(p0.errorCode.toString(), p0.localizedMessage, mapJson(p0.data))
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
                val mapped = mapObject(p0)
                channelResult.success(mapped)
            }

            override fun onError(p0: GigyaError?) {
                p0?.let {
                    channelResult.error(p0.errorCode.toString(), p0.localizedMessage, mapJson(p0.data))
                } ?: channelResult.notImplemented()
            }

        })
    }

    /**
     * Forgot password.
     */
    fun forgotPassword(arguments: Any, channelResult: MethodChannel.Result) {
        val loginId: String? = (arguments as Map<*, *>)["loginId"] as String?
        if (loginId == null) {
            currentResult!!.error(MISSING_PARAMETER_ERROR, MISSING_PARAMETER_MESSAGE, mapOf<String, Any>())
            return
        }
        sdk.forgotPassword(loginId, object : GigyaCallback<GigyaApiResponse>() {
            override fun onSuccess(p0: GigyaApiResponse?) {
                channelResult.success(p0)
            }

            override fun onError(p0: GigyaError?) {
                p0?.let {
                    channelResult.error(p0.errorCode.toString(), p0.localizedMessage, mapJson(p0.data))
                } ?: channelResult.notImplemented()
            }

        });
    }

    /**
     * Init SDK.
     */
    fun initSdk(arguments: Any, channelResult: MethodChannel.Result) {
        val apiKey: String? = (arguments as Map<*, *>)["apiKey"] as String?
        if (apiKey == null) {
            channelResult.success(mapOf("success" to false))

            currentResult!!.error(MISSING_PARAMETER_ERROR, MISSING_PARAMETER_MESSAGE, mapOf<String, Any>())
            return
        }
        val apiDomain: String? = (arguments as Map<*, *>)["apiDomain"] as String?
        if (apiDomain == null) {
            channelResult.success(mapOf("success" to false))

            currentResult!!.error(MISSING_PARAMETER_ERROR, MISSING_PARAMETER_MESSAGE, mapOf<String, Any>())
            return
        }
        sdk.init(apiKey, apiDomain);

        channelResult.success(mapOf("success" to true))
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
                    channelResult.error(p0.errorCode.toString(), p0.localizedMessage, mapJson(p0.data))
                } ?: channelResult.notImplemented()
            }

        });
    }

    /**
     * Social login with given provider & provider sessions.
     */
    fun socialLogin(arguments: Any, channelResult: MethodChannel.Result) {
        currentResult = channelResult
        val provider: String? = (arguments as Map<*, *>)["provider"] as String?
        if (provider == null) {
            currentResult!!.error(MISSING_PARAMETER_ERROR, MISSING_PARAMETER_MESSAGE, mapOf<String, Any>())
            return
        }
        val parameters: MutableMap<String, Any> = arguments["parameters"] as MutableMap<String, Any>?
                ?: mutableMapOf()
        sdk.login(provider, parameters, object : GigyaLoginCallback<T>() {
            override fun onSuccess(p0: T) {
                val mapped = mapObject(p0)
                resolverHelper.clear()
                currentResult!!.success(mapped)
            }

            override fun onError(p0: GigyaError?) {
                p0?.let {
                    currentResult!!.error(p0.errorCode.toString(), p0.localizedMessage, mapJson(p0.data))
                } ?: currentResult!!.notImplemented()
            }

            override fun onOperationCanceled() {
                currentResult!!.error(CANCELED_ERROR, CANCELED_ERROR_MESSAGE, null)
            }

            override fun onConflictingAccounts(response: GigyaApiResponse, resolver: ILinkAccountsResolver) {
                resolverHelper.linkAccountResolver = resolver
                currentResult!!.error(response.errorCode.toString(), response.errorDetails, response.asMap())
            }

            override fun onPendingRegistration(response: GigyaApiResponse, resolver: IPendingRegistrationResolver) {
                resolverHelper.pendingRegistrationResolver = resolver
                currentResult!!.error(response.errorCode.toString(), response.errorDetails, response.asMap())
            }

            override fun onPendingVerification(response: GigyaApiResponse, regToken: String?) {
                resolverHelper.regToken = regToken
                currentResult!!.error(response.errorCode.toString(), response.errorDetails, response.asMap())
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
                val mapped = mapObject(p0)
                channelResult.success(mapped)
            }

            override fun onError(p0: GigyaError?) {
                p0?.let {
                    channelResult.error(p0.errorCode.toString(), p0.localizedMessage, mapJson(p0.data))
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
                    channelResult.error(p0.errorCode.toString(), p0.localizedMessage, mapJson(p0.data))
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
                screenSetsEventsSink?.success(mapOf("event" to "onLogin", "data" to mapObject(accountObj)))
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
     * Link account - handler for fetching conflicting accounts from current intrruption state.
     */
    fun resolveGetConflictingAccounts(channelResult: MethodChannel.Result) {
        resolverHelper.linkAccountResolver?.let { resolver ->
            val conflictingAccounts = resolver.conflictingAccounts
            channelResult.success(mapObject(conflictingAccounts));
        } ?: channelResult.notImplemented()

    }

    /**
     * Link account - resolving link to site.
     */
    fun resolveLinkToSite(arguments: Any, channelResult: MethodChannel.Result) {
        currentResult = channelResult
        resolverHelper.linkAccountResolver?.let { resolver ->
            val loginId: String? = (arguments as Map<*, *>)["loginId"] as String?
            if (loginId == null) {
                channelResult.error(MISSING_PARAMETER_ERROR, MISSING_PARAMETER_MESSAGE, mapOf<String, Any>())
                return
            }
            val password: String? = (arguments as Map<*, *>)["password"] as String?
            if (password == null) {
                channelResult.error(MISSING_PARAMETER_ERROR, MISSING_PARAMETER_MESSAGE, mapOf<String, Any>())
                return
            }
            resolver.linkToSite(loginId, password)

        } ?: channelResult.notImplemented()
    }

    /**
     * Link account - resolving link to social.
     */
    fun resolveLinkToSocial(arguments: Any, channelResult: MethodChannel.Result) {
        currentResult = channelResult
        resolverHelper.linkAccountResolver?.let { resolver ->
            val provider: String? = (arguments as Map<*, *>)["provider"] as String?
            if (provider == null) {
                channelResult.error(MISSING_PARAMETER_ERROR, MISSING_PARAMETER_MESSAGE, mapOf<String, Any>())
                return
            }
            resolver.linkToSocial(provider)

        } ?: channelResult.notImplemented()
    }

    /**
     * Pending registration - resolving missing account data.
     */
    fun resolveSetAccount(arguments: Any, channelResult: MethodChannel.Result) {
        currentResult = channelResult
        resolverHelper.pendingRegistrationResolver?.let { resolver ->
            val data: Map<String, Any>? = arguments as Map<String, Any>
            if (data == null) {
                channelResult.error(MISSING_PARAMETER_ERROR, MISSING_PARAMETER_MESSAGE, mapOf<String, Any>())
                return
            }
            resolver.setAccount(data)
        } ?: channelResult.notImplemented()
    }

    /**
     * Map typed object to a Map<String, Any> object in order to pass on to
     * the method channel response.
     */
    private fun <V> mapObject(obj: V): Map<String, Any> {
        val jsonString = gson.toJson(obj)
        return gson.fromJson(jsonString, object : TypeToken<Map<String, Any>>() {}.type)
    }

    /**
     * Map a JSON string to a Map<String, Any> object in order to pass on to
     * the method channel response.
     */
    private fun mapJson(jsonString: String): Map<String, Any> {
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

class ResolverHelper {

    var linkAccountResolver: ILinkAccountsResolver? = null
    var pendingRegistrationResolver: IPendingRegistrationResolver? = null
    var regToken: String? = null

    fun clear() {
        linkAccountResolver = null
        pendingRegistrationResolver = null
        regToken = null
    }
}