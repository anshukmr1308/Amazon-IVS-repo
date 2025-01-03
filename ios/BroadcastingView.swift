////
////  BroadcastingView.swift
////  AmazonIVSProject
////
////  Created by macmini on 02/01/25.
////
//
//import Foundation
//import UIKit
//import AmazonIVSBroadcast
//
//@objc(BroadcastingView)
//class BroadcastingView: UIView {
//    private var broadcastSession: IVSBroadcastSession?
//    
//    @objc var streamKey: String = "" // Set from React Native
//    @objc var ingestEndpoint: String = "" // Set from React Native
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupBroadcastSession()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupBroadcastSession()
//    }
//    
//    private func setupBroadcastSession() {
//        guard let config = IVSBroadcastSessionConfiguration.makeDefault() else {
//            print("Failed to create default configuration")
//            return
//        }
//        
//        config.video.bitrate = 3000000
//        config.video.width = 1280
//        config.video.height = 720
//        config.video.targetFrameRate = 30
//        config.audio.bitrate = 128000
//        
//        do {
//            broadcastSession = try IVSBroadcastSession(configuration: config, delegate: nil)
//            
//            let camera = try broadcastSession?.addVideoDevice(IVSBroadcastSessionDevicePosition.front)
//            let microphone = try broadcastSession?.addAudioDevice()
//            
//            camera?.setAspectMode(.fit) // Adjust to fit the upper part of the screen
//            
//            // Start broadcasting
//            if !streamKey.isEmpty, !ingestEndpoint.isEmpty {
//                try broadcastSession?.start(with: ingestEndpoint, streamKey: streamKey)
//                print("Broadcast started successfully")
//            }
//        } catch {
//            print("Failed to start broadcasting: \(error.localizedDescription)")
//        }
//    }
//    
//    func stopBroadcasting() {
//        broadcastSession?.stop()
//        print("Broadcast stopped")
//    }
//}
