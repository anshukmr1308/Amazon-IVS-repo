//
//  PermissionManager.swift
//  AmazonIVSProject
//
//  Created by macmini on 09/01/25.
//

import AVFoundation

func checkAVPermissions(_ result: @escaping (Bool) -> Void) {
    checkOrGetPermission(for: .video) { granted in
        guard granted else {
            result(false)
            return
        }
        checkOrGetPermission(for: .audio) { granted in
            guard granted else {
                result(false)
                return
            }
            result(true)
        }
    }
}

func checkOrGetPermission(for mediaType: AVMediaType, _ result: @escaping (Bool) -> Void) {
    func mainThreadResult(_ success: Bool) {
        DispatchQueue.main.async { result(success) }
    }
    switch AVCaptureDevice.authorizationStatus(for: mediaType) {
        case .authorized: mainThreadResult(true)
        case .notDetermined: AVCaptureDevice.requestAccess(for: mediaType) { mainThreadResult($0) }
        case .denied, .restricted: mainThreadResult(false)
        @unknown default: mainThreadResult(false)
    }
}
