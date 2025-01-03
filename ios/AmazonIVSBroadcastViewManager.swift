//
//  AmazonIVSBroadcastViewManager.swift
//  AmazonIVSProject
//
//  Created by macmini on 02/01/25.
//

import Foundation
import React

@objc(AmazonIVSBroadcastViewManager)
class AmazonIVSBroadcastViewManager: RCTViewManager {
    
    override func view() -> UIView! {
        return AmazonIVSBroadcastView()
    }
    
    @objc override static func requiresMainQueueSetup() -> Bool {
        return true
    }
}

