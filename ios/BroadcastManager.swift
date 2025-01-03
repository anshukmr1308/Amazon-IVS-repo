//import Foundation
//import AmazonIVSBroadcast
//import React
//
//@objc(BroadcastManager)
//class BroadcastManager: NSObject {
//    static let shared = BroadcastManager()
//    
//    private var broadcastSession: IVSBroadcastSession?
//    private var broadcastDelegate: BroadcastDelegate?
//    private var deviceDiscovery: IVSDeviceDiscovery?
//    private var localDevices: [IVSDevice] = []
//    
//    override init() {
//        super.init()
//        self.deviceDiscovery = IVSDeviceDiscovery()
//        self.broadcastDelegate = BroadcastDelegate()
//    }
//    
//    @objc func initializeBroadcast(
//        _ resolve: @escaping RCTPromiseResolveBlock,
//        reject: @escaping RCTPromiseRejectBlock
//    ) {
//        do {
//            let config = IVSPresets.configurations().standardPortrait()
//            broadcastSession = try IVSBroadcastSession(
//                configuration: config,
//                descriptors: nil,
//                delegate: broadcastDelegate
//            )
//            setupCamera()
//            setupMicrophone()
//            resolve(NSNumber(value: true))
//        } catch {
//            reject("INIT_ERROR", "Failed to initialize broadcast: \(error.localizedDescription)", error)
//        }
//    }
//    
//    @objc func startBroadcast(
//        _ ingestEndpoint: String,
//        streamKey: String,
//        resolve: @escaping RCTPromiseResolveBlock,
//        reject: @escaping RCTPromiseRejectBlock
//    ) {
//        guard let session = broadcastSession else {
//            reject("NO_SESSION", "Broadcast session not initialized", nil)
//            return
//        }
//        
//        do {
//            let url = URL(string: "rtmps://\(ingestEndpoint)")!
//            try session.start(with: url, streamKey: streamKey)
//            resolve(NSNumber(value: true))
//        } catch {
//            reject("START_ERROR", "Failed to start broadcast: \(error.localizedDescription)", error)
//        }
//    }
//    
//    @objc func stopBroadcast(
//        _ resolve: @escaping RCTPromiseResolveBlock,
//        reject: @escaping RCTPromiseRejectBlock
//    ) {
//        broadcastSession?.stop()
//        resolve(NSNumber(value: true))
//    }
//    
//    private func setupCamera() {
//        guard let devices = deviceDiscovery?.listLocalDevices() else { return }
//        
//        if let camera = devices.compactMap({ $0 as? IVSCamera }).first {
//            if let cameraSource = camera.listAvailableInputSources().first(where: { $0.position == .front }) {
//                camera.setPreferredInputSource(cameraSource) { [weak self] error in
//                    if let error = error {
//                        print("Camera setup error: \(error.localizedDescription)")
//                        return
//                    }
//                    self?.localDevices.append(camera)
//                    if let session = self?.broadcastSession {
//                      try? session.attach(camera, toSlotWithName: <#String?#>)
//                    }
//                }
//            }
//        }
//    }
//    
//    private func setupMicrophone() {
//        guard let devices = deviceDiscovery?.listLocalDevices() else { return }
//        
//        if let microphone = devices.compactMap({ $0 as? IVSMicrophone }).first {
//            microphone.isEchoCancellationEnabled = true
//            localDevices.append(microphone)
//            if let session = broadcastSession {
//              try? session.attach(microphone, toSlotWithName: <#String?#>)
//            }
//        }
//    }
//}
