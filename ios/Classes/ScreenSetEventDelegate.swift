/// This interface defines a handler for screen set events.
protocol ScreenSetEventDelegate {
    /// Add an error event to the event sink.
    func addScreenSetError(errorCode: String, errorMessage: String, errorDetails: Any?) -> Void

    /// Add the given event to the event sink.
    func addScreenSetEvent(event: [String, Any?]) -> Void
}