//
//  BroadcastEventEmitter.swift
//  AmazonIVSProject
//
//  Created by macmini on 21/01/25.
//


import Foundation
import React

@objc(BroadcastEventEmitter)
class BroadcastEventEmitter: RCTEventEmitter {
    
    public static var shared: BroadcastEventEmitter?
    
    override init() {
        super.init()
        BroadcastEventEmitter.shared = self
    }
    
    override func supportedEvents() -> [String] {
        return ["onBroadcastAppear", "onPreviewPageState"]
    }
    
    // Existing methods
    @objc func emitBroadcastAppearEvent() {
        sendEvent(withName: "onBroadcastAppear", body: ["isPresent": true])
    }

    @objc func emitBroadcastDisappearEvent() {
        sendEvent(withName: "onBroadcastAppear", body: ["isPresent": false])
    }
    
    // Make sure this method is marked with @objc
    @objc func emitPreviewPageState(_ isPreviewPage: Bool) {
        sendEvent(withName: "onPreviewPageState", body: ["isPreviewPage": isPreviewPage])
    }
}
