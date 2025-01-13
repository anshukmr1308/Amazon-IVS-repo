//import Foundation
//import AmazonIVSBroadcast
//import React
//
//@objc(BroadcastViewManager)
//class BroadcastViewManager: RCTViewManager {
//    override func view() -> UIView! {
//        return BroadcastView()
//    }
//    
//    override static func requiresMainQueueSetup() -> Bool {
//        return true
//    }
//}
//
//class BroadcastView: UIView {
//    private var deviceDiscovery = IVSDeviceDiscovery()
//    private var broadcastSession: IVSBroadcastSession?
//    private var localCamera: IVSCamera?
//    private var localMicrophone: IVSMicrophone?
//    private var broadcastDelegate: BroadcastDelegate?
//    
//    private var isBroadcasting: Bool = false {
//        didSet {
//            // Notify React Native of broadcasting state change
//            if let onBroadcastStateChange = onBroadcastStateChange {
//                onBroadcastStateChange(["isBroadcasting": isBroadcasting])
//            }
//        }
//    }
//    
//    @objc var onBroadcastStateChange: RCTDirectEventBlock?
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupBroadcast()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupBroadcast()
//    }
//    
//    private func setupBroadcast() {
//        broadcastDelegate = BroadcastDelegate()
//        setupCamera()
//    }
//    
//    private func setupCamera() {
//        #if !targetEnvironment(simulator)
//        let devices = deviceDiscovery.listLocalDevices()
//        
//        // Setup Camera
//        if let camera = devices.compactMap({ $0 as? IVSCamera }).first {
//            if let cameraSource = camera.listAvailableInputSources().first(where: { $0.position == .front }) {
//                camera.setPreferredInputSource(cameraSource) { [weak self] error in
//                    if let error = error {
//                        print("Camera setup error: \(error)")
//                    } else {
//                        self?.localCamera = camera
//                        self?.setupBroadcastSession()
//                    }
//                }
//            }
//        }
//        
//        // Setup Microphone
//        if let microphone = devices.compactMap({ $0 as? IVSMicrophone }).first {
//            // Configure audio settings using IVSStageAudioManager
//            let audioManager = IVSStageAudioManager.shared
//            audioManager.echoCancellation = .enabled
//            audioManager.noiseReduction = .enabled
//            self.localMicrophone = microphone
//        }
//        #endif
//    }
//    
//    private func setupBroadcastSession() {
//        do {
//            let config = IVSPresets.configurations().standardPortrait()
//            broadcastSession = try IVSBroadcastSession(configuration: config,
//                                                     descriptors: nil,
//                                                     delegate: broadcastDelegate)
//            
//            if let camera = localCamera {
//                try broadcastSession?.attach(camera, toSlotWithName: "camera")
//            }
//            
//            if let microphone = localMicrophone {
//                try broadcastSession?.attach(microphone, toSlotWithName: "microphone")
//            }
//            
//        } catch {
//            print("Broadcast session setup error: \(error)")
//        }
//    }
//    
//    @objc func startBroadcast(_ streamURL: String, streamKey: String) {
//        guard let url = URL(string: streamURL) else { return }
//        
//        do {
//            try broadcastSession?.start(with: url, streamKey: streamKey)
//            isBroadcasting = true
//        } catch {
//            print("Start broadcast error: \(error)")
//        }
//    }
//    
//    @objc func stopBroadcast() {
//        broadcastSession?.stop()
//        isBroadcasting = false
//    }
//    
//    @objc func switchCamera() {
//        guard let camera = localCamera else { return }
//        
//        let currentPosition = camera.descriptor().position
//        let newPosition: IVSDevicePosition = currentPosition == .front ? .back : .front
//        
//        if let newSource = camera.listAvailableInputSources().first(where: { $0.position == newPosition }) {
//            camera.setPreferredInputSource(newSource) { error in
//                if let error = error {
//                    print("Camera switch error: \(error)")
//                }
//            }
//        }
//    }
//}
