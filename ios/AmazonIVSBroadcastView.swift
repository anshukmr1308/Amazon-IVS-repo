//
//  AmazonIVSBroadcastView.swift
//  AmazonIVSProject
//
//  Created by macmini on 02/01/25.
//

import Foundation
import SwiftUI
import AmazonIVSBroadcast
//
//@objc(AmazonIVSBroadcastView)
//class AmazonIVSBroadcastView: UIView {
//
//    private var broadcastSession: IVSBroadcastSession?
//    private var previewView: UIView?
//
//    @objc var ingestEndpoint: String = "" {
//        didSet { setupBroadcastSession() }
//    }
//
//    @objc var streamKey: String = "" {
//        didSet { setupBroadcastSession() }
//    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupPreview()
//    }
//
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupPreview()
//    }
//
//    private func setupPreview() {
//        previewView = UIView(frame: self.bounds)
//        if let previewView = previewView {
//            self.addSubview(previewView)
//        }
//    }
//
//    private func setupBroadcastSession() {
//        guard !ingestEndpoint.isEmpty, !streamKey.isEmpty else {
//            print("Missing ingestEndpoint or streamKey")
//            return
//        }
//
//        do {
//            let config = IVSBroadcastConfiguration()
//            // Explicitly specify the type for preset
////            config.preset = IVSBroadcastPreset.standardPortrait
//
//            broadcastSession = try IVSBroadcastSession(configuration: config, descriptors: nil, delegate: nil)
//
//            if let preview = broadcastSession?.previewView {
//                let preview = IVSImagePreviewView(frame: self.bounds)
//                preview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//                self.addSubview(preview)
//            }
//
//            try broadcastSession?.start(with: URL(string: ingestEndpoint)!, streamKey: streamKey)
//            print("Broadcast session started")
//        } catch {
//            print("Failed to start IVS Broadcast Session: \(error.localizedDescription)")
//        }
//    }
//
//    @objc func stopBroadcast() {
//        broadcastSession?.stop()
//        print("Broadcast session stopped")
//    }
//}








//  override init(frame: CGRect) {
//      super.init(frame: frame)
//      setupView()
//  }
//
//  required init?(coder: NSCoder) {
//      super.init(coder: coder)
//      setupView()
//  }
//
//  private func setupView() {
//      let label = UILabel()
//      label.text = "anshu"
//      label.textColor = .blue
//      label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
//      label.textAlignment = .center
//
//      label.translatesAutoresizingMaskIntoConstraints = false
//      addSubview(label)
//
//      NSLayoutConstraint.activate([
//          label.centerXAnchor.constraint(equalTo: centerXAnchor),
//          label.centerYAnchor.constraint(equalTo: centerYAnchor)
//      ])
//
//      backgroundColor = .white
//  }

class BroadcastViewState: ObservableObject {
    static let shared = BroadcastViewState() // Singleton instance
    
    @Published var isStageListPresent: Bool = false
    @Published var isLoading: Bool = false
    @Published var isStagePresent: Bool = false
    @Published var isSetupPresent: Bool = true
    @Published var isWelcomePresent: Bool = true
    @Published var isCameraPreviewPresent: Bool = false
    @Published var selectedStage: StageDetails?
    @Published var stages: [StageDetails] = []
    @Published var isPreviewActive: Bool = true
}

struct AmazonIVSBroadcastView: View {
    @ObservedObject var services = ServicesManager()
  @ObservedObject var viewState: BroadcastViewState

  
  var username: String = "Vijay"
     var avatarUrl: String = "https://d39ii5l128t5ul.cloudfront.net/assets/animals_square/bear.png"
     var joinToken: String = ""
  
  init(viewState: BroadcastViewState = BroadcastViewState.shared) {
          self.viewState = viewState
      }
  
    var body: some View {
        ZStack(alignment: .top) {
            Color("Background")
                .edgesIgnoringSafeArea(.all)

          if viewState.isStagePresent, let viewModel = services.viewModel {
                         StageView(viewModel: viewModel,
                                  chatModel: services.chatModel,
                                  isPresent: $viewState.isStagePresent,
                                  isLoading: $viewState.isLoading,
                                  backAction: backAction)
                             .transition(.slide)
                     }


          if viewState.isSetupPresent {
              ZStack(alignment: .topLeading) {
                  Color("Background")
                      .edgesIgnoringSafeArea(.all)

//                if viewState.isCameraPreviewPresent, let viewModel = services.viewModel {
//                      JoinPreviewView(viewModel: viewModel, isPresent:
//                                        $viewState.isCameraPreviewPresent, isLoading: $viewState.isLoading, isPreviewActive: $viewState.isPreviewActive) {
//                        guard let stage = viewState.selectedStage else {
//                              print("❌ Can't join - no stage selected")
//                              return
//                          }
//                        viewState.isStageListPresent = false
//                        joinStage(stage)
//                      }
//                  }
              }
              .onAppear {
                viewState.isLoading = true
                BroadcastEventEmitter.shared?.emitBroadcastAppearEvent()

                  DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                      services.viewModel?.getAllStages(initial: true) { allStages in
                        viewState.stages = allStages
                        viewState.isLoading = false
                      }
                  }
              }
          }



            if let viewModel = services.viewModel {
                NotificationsView(viewModel: viewModel)
            }

          if viewState.isLoading {
                ActivityIndicator()
            }
        }
        .environmentObject(services)
    }
  
  
  public func createStage() {
         print("createStage called in SwiftUI view")
         viewState.isLoading = true
         handleSetupCompletion(user: updateUser(true), token: nil)
     }
  
  public func onClickStage(stage: StageDetails) {
    viewState.selectedStage = stage
    viewState.isCameraPreviewPresent = true
  }

  private func joinStage(_ stage: StageDetails) {
    viewState.isLoading = true
      print("ℹ joining stage: \(stage.stageId)")

      services.viewModel?.getToken(for: stage) { stageJoinResponse, error in
          if let token = stageJoinResponse?.stage.token {
              print("ℹ stage auth successful - got token: \(token)")
              services.server.stageDetails = stage
              services.server.joinedStagePlaybackUrl = services.server.stageHostDetails?.channel.playbackUrl ?? ""
            handleSetupCompletion(user: updateUser(), token: stageJoinResponse?.stage.token.token)
          } else {
              print("❌ Could not join stage - missing stage join token: \(error ?? "\(String(describing: stageJoinResponse))")")
          }
        DispatchQueue.main.async {
                    viewState.isLoading = false
                }
      }
  }

  @discardableResult
  private func updateUser(_ asHost: Bool = false) -> User {
      services.user.username = username
      services.user.avatarUrl = avatarUrl
      services.user.isHost = asHost
      UserDefaults.standard.set(services.user.username, forKey: "username")
      UserDefaults.standard.set(services.user.avatarUrl, forKey: "avatar")
      return services.user
  }

  private func handleSetupCompletion(user: User, token: String?) {

          services.viewModel?.clearNotifications()
          services.user = user
    
          if user.isHost {
            print("After setting user in handleSetupCompletion:-------------------------------------------",  user.isHost )
              services.viewModel?.createStage(user: user) { success in
                  if success {
                      services.viewModel?.initializeStage {
                          services.viewModel?.joinAsHost { success in
                              if success {
                                print("After:-------------------------------------------",  user.isHost )
                                  presentStage()
                              }
                            DispatchQueue.main.async {
                                        viewState.isLoading = false
                                    }
                          }
                      }
                  } else {
                    viewState.isLoading = false
                  }
              }
          } else if let token = token {
              services.viewModel?.initializeStage {
                  services.viewModel?.joinAsParticipant(token) {
                      presentStage()
                    DispatchQueue.main.async {
                                viewState.isLoading = false
                            }
                  }
              }
          }
      }

  private func presentStage() {
         DispatchQueue.main.async {
             withAnimation {
                 viewState.isSetupPresent = !viewState.isSetupPresent
                 viewState.isWelcomePresent = !viewState.isWelcomePresent
                 viewState.isStagePresent = true
             }
         }
     }
  
  
    private func backAction() {
      BroadcastEventEmitter.shared?.emitBroadcastAppearEvent()
      viewState.isSetupPresent = true
      viewState.isStageListPresent = true
        withAnimation {
          viewState.isStagePresent = false
        }
      viewState.isLoading = false
    }
  
  func handleCancel() {
         if let viewModel = services.viewModel {
             JoinPreviewView(viewModel: viewModel,
                           isPresent: $viewState.isCameraPreviewPresent,
                           isLoading: $viewState.isLoading,
                             isPreviewActive: $viewState.isPreviewActive
             ) {
             }.handleCancel()
         }
     }

  func handleJoin() {
//             if let viewModel = services.viewModel {
//                 JoinPreviewView(viewModel: viewModel,
//                               isPresent: $viewState.isCameraPreviewPresent,
//                               isLoading: $viewState.isLoading,
//                                 isPreviewActive: $viewState.isPreviewActive
//                 ) {
//                     guard let stage = viewState.selectedStage else {
//                         print("❌ Can't join - no stage selected")
//                         return
//                     }
//                     viewState.isStageListPresent = false
//                     joinStage(stage)
//                 }.handleJoin()
//      }
  }

  
  func sendMessage(_ message: String) {
         if let viewModel = services.viewModel {
             services.chatModel.sendMessage(message, user: services.user) { error in
                 if let error = error {
                     viewModel.appendErrorNotification(error)
                 }
             }
         }
     }
}



//      viewState.isLoading = true
//      viewState.isPreviewActive = false
//
//      DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//          guard let stage = viewState.selectedStage else {
//              print("❌ Can't join - no stage selected")
//              viewState.isLoading = false
//              return
//          }
//
//          // Toggle camera preview presence to match Swift button behavior
//          viewState.isCameraPreviewPresent = false
//
//          // Then proceed with joining stage
//          viewState.isStageListPresent = false
//          joinStage(stage)
