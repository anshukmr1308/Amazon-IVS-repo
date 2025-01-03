//
//  AmazonIVSBroadcastView.swift
//  AmazonIVSProject
//
//  Created by macmini on 02/01/25.
//

import Foundation
import UIKit
import AmazonIVSBroadcast

@objc(AmazonIVSBroadcastView)
class AmazonIVSBroadcastView: UIView {
    
    private var broadcastSession: IVSBroadcastSession?
    private var previewView: UIView?
    
    @objc var ingestEndpoint: String = "" {
        didSet { setupBroadcastSession() }
    }
    
    @objc var streamKey: String = "" {
        didSet { setupBroadcastSession() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPreview()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupPreview()
    }
    
    private func setupPreview() {
        previewView = UIView(frame: self.bounds)
        if let previewView = previewView {
            self.addSubview(previewView)
        }
    }
    
    private func setupBroadcastSession() {
        guard !ingestEndpoint.isEmpty, !streamKey.isEmpty else {
            print("Missing ingestEndpoint or streamKey")
            return
        }
        
        do {
            let config = IVSBroadcastConfiguration()
            // Explicitly specify the type for preset
//            config.preset = IVSBroadcastPreset.standardPortrait
            
            broadcastSession = try IVSBroadcastSession(configuration: config, descriptors: nil, delegate: nil)
            
            if let preview = broadcastSession?.previewView {
                let preview = IVSImagePreviewView(frame: self.bounds)
                preview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                self.addSubview(preview)
            }
            
            try broadcastSession?.start(with: URL(string: ingestEndpoint)!, streamKey: streamKey)
            print("Broadcast session started")
        } catch {
            print("Failed to start IVS Broadcast Session: \(error.localizedDescription)")
        }
    }
    
    @objc func stopBroadcast() {
        broadcastSession?.stop()
        print("Broadcast session stopped")
    }
}
