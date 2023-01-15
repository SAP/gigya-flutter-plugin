/// This interface defines a handler for screen set events.
protocol ScreenSetEventDelegate {
    /// Add the given event to the event sink.
    func addScreenSetEvent(event: [String: Any?]) -> Void
}