//import Foundation
//
//@objc(ServicesManager)
//class ServicesManager: NSObject {
//    var server: ServerManager
//    var user: User
//    var chatModel: ChatModel
//    var viewModel: StageViewModel? // Will be properly implemented when you provide the ViewModel code
//    
//    
//    public override init() {
//        self.server = ServerManager()
//        self.user = User(
//          username: UserDefaults.standard.string(forKey: "username")!,
//          avatarUrl: UserDefaults.standard.string(forKey: "avatar")!
//        )
//        self.chatModel = ChatModel()
//        super.init()
//        
//        // Initialize ViewModel and set up delegates
//        self.viewModel = StageViewModel(services: self)
//      self.server.delegate = self.viewModel as! any ServerManagerDelegate
//    }
//    
//    // MARK: - Public Methods
//    @objc func disconnectFromStage(
//        _ resolve: @escaping RCTPromiseResolveBlock,
//        reject: @escaping RCTPromiseRejectBlock
//    ) {
//        chatModel.disconnect()
//        
//        if user.isHost {
//            viewModel?.endSession()
//            viewModel?.deleteStage(onComplete: { [weak self] in
//                self?.user.isHost = false
//                resolve(nil)
//            })
//        } else {
//            viewModel?.endSession()
//            resolve(nil)
//        }
//    }
//

//
//  ServicesManager.swift
//  Stages-demo
//
//  Created by Uldis Zingis on 31/08/2022.
//

import SwiftUI

class ServicesManager: ObservableObject {
    @ObservedObject var server: Server
    @ObservedObject var user: User
    @ObservedObject var chatModel = ChatModel()

    @Published var viewModel: StageViewModel?

    init() {
        self.server = Server()
        self.user = User(username: UserDefaults.standard.string(forKey: "username") ?? "",
                         avatarUrl: UserDefaults.standard.string(forKey: "avatar") ?? Constants.userAvatarUrls.first ?? "")
      print("ServicesManager init isHost:*************************************************", self.user.isHost)
        self.viewModel = StageViewModel(services: self)
        server.delegate = viewModel
    }

    func disconnectFromStage(_ onComplete: @escaping () -> Void) {
        chatModel.disconnect()

        if user.isHost {
            viewModel?.endSession()
            viewModel?.deleteStage(onComplete: { [weak self] in
                self?.user.isHost = false
                onComplete()
            })
        } else {
            viewModel?.endSession()
            onComplete()
        }
    }

    func connect(to chat: Chat) {
        print("ℹ Connecting to chat room \(chat.id)")
        let tokenRequest = ChatTokenRequest(user: user, chatRoomId: chat.id, chatRoomToken: chat.token)
        chatModel.connectChatRoom(tokenRequest) { error in
            if let error = error {
                self.viewModel?.appendErrorNotification(error)
            }
        }
    }
}
