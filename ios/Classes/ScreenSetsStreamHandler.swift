//
//  ScreenSetsStreamHandler.swift
//  gigya_flutter_plugin
//
//  Created by Shmuel, Sagi on 26/11/2020.
//

import Foundation

/**
 Screensete event handler stream handler.
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
