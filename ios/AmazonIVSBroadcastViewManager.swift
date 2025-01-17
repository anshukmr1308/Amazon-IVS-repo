//
//  AmazonIVSBroadcastViewManager.swift
//  AmazonIVSProject
//
//  Created by macmini on 02/01/25.
//
//
//import Foundation
//import React

//@objc(AmazonIVSBroadcastViewManager)
//class AmazonIVSBroadcastViewManager: RCTViewManager {
//    
//    override func view() -> UIView! {
//        return AmazonIVSBroadcastView()
//    }
//    
//    @objc override static func requiresMainQueueSetup() -> Bool {
//        return true
//    }
//}

//@objc(AmazonIVSBroadcastViewManager)
//class AmazonIVSBroadcastViewManager: RCTViewManager {
//    override func view() -> UIView! {
//        return AmazonIVSBroadcastView()
//    }
//    
//    override static func requiresMainQueueSetup() -> Bool {
//        return true
//    }
//}


import Foundation
import SwiftUI
import UIKit
import React

@objc(AmazonIVSBroadcastViewManager)
class AmazonIVSBroadcastViewManager: RCTViewManager {
    private var broadcastViewWrapper: AmazonIVSBroadcastViewWrapper?

    override func view() -> UIView! {
        print("Initializing the view in AmazonIVSBroadcastViewManager")
        
        let containerView = UIView()
        containerView.isUserInteractionEnabled = true

        // Initialize the wrapper
        let wrapper = AmazonIVSBroadcastViewWrapper()
        wrapper.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(wrapper)

        NSLayoutConstraint.activate([
            wrapper.topAnchor.constraint(equalTo: containerView.topAnchor),
            wrapper.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            wrapper.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            wrapper.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])

        self.broadcastViewWrapper = wrapper // Assign the wrapper to the property
        print("broadcastViewWrapper is initialized")
        return containerView
    }

    override static func requiresMainQueueSetup() -> Bool {
        return true
    }

    @objc func createStageFromReact() {
        DispatchQueue.main.async { [weak self] in
            print("React Native Button Clicked")
            
            // Lazy initialization in case broadcastViewWrapper is nil
            if self?.broadcastViewWrapper == nil {
                print("broadcastViewWrapper is nil; initializing...")
                self?.broadcastViewWrapper = AmazonIVSBroadcastViewWrapper()
            }
            
            guard let broadcastViewWrapper = self?.broadcastViewWrapper else {
                print("Error: broadcastViewWrapper could not be initialized")
                return
            }

            print("Calling createStage on broadcastViewWrapper")
            broadcastViewWrapper.createStage()
        }
    }
}

class AmazonIVSBroadcastViewWrapper: UIView {
    private var hostingController: UIHostingController<AmazonIVSBroadcastView>?
  private let viewState = BroadcastViewState.shared

    override init(frame: CGRect) {
        super.init(frame: frame)
        print("AmazonIVSBroadcastViewWrapper initialized with frame")
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print("AmazonIVSBroadcastViewWrapper initialized with coder")
        setupView()
    }

    private func setupView() {
        print("Setting up the hosting controller in AmazonIVSBroadcastViewWrapper")
        let broadcastView = AmazonIVSBroadcastView()
        let hostingController = UIHostingController(rootView: broadcastView)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear
        hostingController.view.isUserInteractionEnabled = true

        self.hostingController = hostingController
        if let hostingView = hostingController.view {
            self.addSubview(hostingView)

            NSLayoutConstraint.activate([
                hostingView.topAnchor.constraint(equalTo: self.topAnchor),
                hostingView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                hostingView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                hostingView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            ])
        }
    }

  func createStage() {
          print("createStage called in broadcastViewWrapper")
          DispatchQueue.main.async { [weak self] in
              guard let hostingController = self?.hostingController else {
                  print("Error: No hosting controller found")
                  return
              }
              hostingController.rootView.createStage()
          }
      }
}


