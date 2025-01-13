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
  override func view() -> UIView! {
         let containerView = UIView()
         containerView.isUserInteractionEnabled = true
         
         let hostingWrapper = AmazonIVSBroadcastViewWrapper()
         hostingWrapper.translatesAutoresizingMaskIntoConstraints = false
         containerView.addSubview(hostingWrapper)

         NSLayoutConstraint.activate([
             hostingWrapper.topAnchor.constraint(equalTo: containerView.topAnchor),
             hostingWrapper.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
             hostingWrapper.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
             hostingWrapper.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
         ])

         return containerView
     }
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
}

class AmazonIVSBroadcastViewWrapper: UIView {
    private var hostingController: UIHostingController<AmazonIVSBroadcastView>?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

  private func setupView() {
      let broadcastView = AmazonIVSBroadcastView()
      hostingController = UIHostingController(rootView: broadcastView)

      if let hostingView = hostingController?.view {
          hostingView.translatesAutoresizingMaskIntoConstraints = false
          hostingView.backgroundColor = .clear // Avoid blocking touches
          hostingView.isUserInteractionEnabled = true

          addSubview(hostingView)

          // Ensure the hostingController manages touches properly
          hostingController?.view.isMultipleTouchEnabled = true

          NSLayoutConstraint.activate([
              hostingView.topAnchor.constraint(equalTo: topAnchor),
              hostingView.leadingAnchor.constraint(equalTo: leadingAnchor),
              hostingView.trailingAnchor.constraint(equalTo: trailingAnchor),
              hostingView.bottomAnchor.constraint(equalTo: bottomAnchor),
          ])
      }

      isUserInteractionEnabled = true // Enable interaction for the wrapper
  }
}
