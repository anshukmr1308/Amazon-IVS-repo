//
//  BroadcastDelegate.swift
//  AmazonIVSProject
//
//  Created by macmini on 03/01/25.
//

//import Foundation
//import AmazonIVSBroadcast
//
//class BroadcastDelegate: NSObject, IVSBroadcastSession.Delegate {
//    func broadcastSession(_ session: IVSBroadcastSession, didChange state: IVSBroadcastSession.State) {
//        NotificationCenter.default.post(
//            name: NSNotification.Name("IVSBroadcastStateChanged"),
//            object: nil,
//            userInfo: ["state": state.rawValue]
//        )
//    }
//    
//    func broadcastSession(_ session: IVSBroadcastSession, didEmitError error: Error) {
//        NotificationCenter.default.post(
//            name: NSNotification.Name("IVSBroadcastError"),
//            object: nil,
//            userInfo: ["error": error.localizedDescription]
//        )
//    }
//}
