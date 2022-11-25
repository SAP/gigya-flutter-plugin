import Foundation

/**
The ScreenSets StreamHandler implementation.
*/
class ScreenSetsStreamHandler: NSObject, FlutterStreamHandler {

    var sink: FlutterEventSink?

    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        sink = events
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        sink = nil
        return nil
    }

    func destroy() {
        sink = nil
    }
}