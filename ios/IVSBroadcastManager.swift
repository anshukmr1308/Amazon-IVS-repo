//import Foundation
//import UIKit
//import AmazonIVSBroadcast
//import React
//
//@objc(IVSBroadcastManager)
//class IVSBroadcastManager: RCTViewManager {
//    
//    private var broadcastSession: IVSBroadcastSession?
//    private var previewView: UIView?
//    private var camera: IVSCamera?
//    private var microphone: IVSMicrophone?
//    
//    override func view() -> UIView! {
//        if previewView == nil {
//            previewView = UIView()
//            setupBroadcastSession()
//        }
//        return previewView
//    }
//    
//    private func setupBroadcastSession() {
//        do {
//            let config = IVSBroadcastConfiguration()
//            config.video.size = CGSize(width: 1280, height: 720)
//            config.video.maxBitrate = 2500000
//            config.video.targetBitrate = 2000000
//            config.video.minBitrate = 600000
//            
//            broadcastSession = try IVSBroadcastSession(configuration: config, descriptors: [], delegate: self)
//            
//            if let previewView = previewView {
//                try broadcastSession?.attach(previewView: previewView)
//            }
//            
//            camera = broadcastSession?.listAttachedDevices().compactMap { $0 as? IVSCamera }.first
//            microphone = broadcastSession?.listAttachedDevices().compactMap { $0 as? IVSMicrophone }.first
//            
//        } catch {
//            print("❌ Failed to initialize IVSBroadcastSession: \(error.localizedDescription)")
//        }
//    }
//    
//    @objc func startStreaming(_ streamKey: String, url: String) {
//        guard let session = broadcastSession, let endpoint = URL(string: url) else {
//            print("❌ Invalid URL or session not initialized.")
//            return
//        }
//        
//        do {
//            try session.start(withStreamKey: streamKey, endpoint: endpoint)
//            print("✅ Streaming started")
//        } catch {
//            print("❌ Failed to start streaming: \(error.localizedDescription)")
//        }
//    }
//    
//    @objc func stopStreaming() {
//        broadcastSession?.stop()
//        print("✅ Streaming stopped")
//    }
//}
//
//// MARK: - IVSBroadcastSessionDelegate
//
//extension IVSBroadcastManager: IVSBroadcastSession.Delegate {
//    func broadcastSession(_ session: IVSBroadcastSession, didChange state: IVSBroadcastSession.State) {
//        print("ℹ IVSBroadcastSession state changed: \(state.text)")
//    }
//    
//    func broadcastSession(_ session: IVSBroadcastSession, didEmitError error: Error) {
//        print("❌ IVSBroadcastSession error: \(error.localizedDescription)")
//    }
//}
//
//// MARK: - IVSBroadcastSession.State Extension
//extension IVSBroadcastSession.State {
//    var text: String {
//        switch self {
//            case .disconnected: return "Disconnected"
//            case .connecting: return "Connecting"
//            case .connected: return "Connected"
//            case .invalid:  return "Invalid"
//            case .error:  return "Error"
//            @unknown default: return "Unknown State"
//        }
//    }
//}
