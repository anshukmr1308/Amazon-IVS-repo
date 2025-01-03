//import Foundation
//import React
//
//@objc(IVSBroadcastBridge)
//class IVSBroadcastBridge: NSObject {
//    
//    @objc func startStreaming(_ streamKey: String, url: String) {
//        DispatchQueue.main.async {
//            NotificationCenter.default.post(name: Notification.Name("StartStreaming"), object: nil, userInfo: ["streamKey": streamKey, "url": url])
//        }
//    }
//    
//    @objc func stopStreaming() {
//        DispatchQueue.main.async {
//            NotificationCenter.default.post(name: Notification.Name("StopStreaming"), object: nil)
//        }
//    }
//}
