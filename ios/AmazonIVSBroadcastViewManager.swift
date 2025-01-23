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
  
  @objc func onClickStageFromReact(_ stage: NSDictionary) {
      DispatchQueue.main.async { [weak self] in
          print("React Native onClickStage Called")

          // Safely extract and convert NSDictionary to StageDetails
          guard
              let roomId = stage["roomId"] as? String,
              let channelId = stage["channelId"] as? String,
              let userAttributesDict = stage["stageAttributes"] as? [String: Any],
              let username = userAttributesDict["username"] as? String,
              let avatarUrl = userAttributesDict["avatarUrl"] as? String,
              let groupId = stage["groupId"] as? String,
              let stageId = stage["stageId"] as? String
          else {
              print("Error: Invalid stage details provided")
              return
          }

          let userAttributes = UserAttributes(username: username, avatarUrl: avatarUrl)
          let stageDetails = StageDetails(
              roomId: roomId,
              channelId: channelId,
              userAttributes: userAttributes,
              groupId: groupId,
              stageId: stageId
          )

          if self?.broadcastViewWrapper == nil {
              print("broadcastViewWrapper is nil; initializing...")
              self?.broadcastViewWrapper = AmazonIVSBroadcastViewWrapper()
          }

          guard let broadcastViewWrapper = self?.broadcastViewWrapper else {
              print("Error: broadcastViewWrapper could not be initialized")
              return
          }

          print("Calling onClickStage on broadcastViewWrapper")
          broadcastViewWrapper.onClickStage(stage: stageDetails)
      }
  }
  
  @objc func handleCancelFromReact() {
         DispatchQueue.main.async { [weak self] in
             print("React Native handleCancel Called")
             
             if self?.broadcastViewWrapper == nil {
                 print("broadcastViewWrapper is nil; initializing...")
                 self?.broadcastViewWrapper = AmazonIVSBroadcastViewWrapper()
             }
             
             guard let broadcastViewWrapper = self?.broadcastViewWrapper else {
                 print("Error: broadcastViewWrapper could not be initialized")
                 return
             }

             print("Calling handleCancel on broadcastViewWrapper")
             broadcastViewWrapper.handleCancel()
         }
     }

     @objc func handleJoinFromReact() {
         DispatchQueue.main.async { [weak self] in
             print("React Native handleJoin Called")
             
             if self?.broadcastViewWrapper == nil {
                 print("broadcastViewWrapper is nil; initializing...")
                 self?.broadcastViewWrapper = AmazonIVSBroadcastViewWrapper()
             }
             
             guard let broadcastViewWrapper = self?.broadcastViewWrapper else {
                 print("Error: broadcastViewWrapper could not be initialized")
                 return
             }

             print("Calling handleJoin on broadcastViewWrapper")
             broadcastViewWrapper.handleJoin()
         }
     }
  
  @objc func sendMessageFromReact(_ message: String) {
          DispatchQueue.main.async { [weak self] in
              print("React Native sendMessage Called with message:", message)
              
              if self?.broadcastViewWrapper == nil {
                  print("broadcastViewWrapper is nil; initializing...")
                  self?.broadcastViewWrapper = AmazonIVSBroadcastViewWrapper()
              }
              
              guard let broadcastViewWrapper = self?.broadcastViewWrapper else {
                  print("Error: broadcastViewWrapper could not be initialized")
                  return
              }

              print("Calling sendMessage on broadcastViewWrapper")
              broadcastViewWrapper.sendMessage(message)
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
  
  func onClickStage(stage: StageDetails) {
      print("onClickStage called in broadcastViewWrapper")
      DispatchQueue.main.async { [weak self] in
          guard let hostingController = self?.hostingController else {
              print("Error: No hosting controller found")
              return
          }
          hostingController.rootView.onClickStage(stage: stage)
      }
  }
  
  func handleCancel() {
          print("handleCancel called in broadcastViewWrapper")
          DispatchQueue.main.async { [weak self] in
              guard let hostingController = self?.hostingController else {
                  print("Error: No hosting controller found")
                  return
              }
              hostingController.rootView.handleCancel()
          }
      }

      func handleJoin() {
          print("handleJoin called in broadcastViewWrapper")
          DispatchQueue.main.async { [weak self] in
              guard let hostingController = self?.hostingController else {
                  print("Error: No hosting controller found")
                  return
              }
              hostingController.rootView.handleJoin()
          }
      }
  
  func sendMessage(_ message: String) {
         print("sendMessage called in broadcastViewWrapper")
         DispatchQueue.main.async { [weak self] in
             guard let hostingController = self?.hostingController else {
                 print("Error: No hosting controller found")
                 return
             }
             hostingController.rootView.sendMessage(message)
         }
     }
  
}


