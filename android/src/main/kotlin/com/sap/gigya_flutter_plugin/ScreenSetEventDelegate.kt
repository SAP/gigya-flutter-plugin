package com.sap.gigya_flutter_plugin

/**
 * This interface defines a handler for screen set events.
 */
interface ScreenSetEventDelegate {
    /**
     * Add the given event to the event sink.
     */
    fun addScreenSetEvent(event: Map<String, Any?>)
}