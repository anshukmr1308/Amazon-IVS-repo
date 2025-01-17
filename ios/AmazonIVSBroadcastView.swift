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
}

struct AmazonIVSBroadcastView: View {
    @ObservedObject var services = ServicesManager()
  @ObservedObject var viewState: BroadcastViewState
//    @State var isWelcomePresent: Bool = true
//    @State var isSetupPresent: Bool = true
//    @State var isStageListPresent: Bool = false
////    @State var isStagePresent: Bool = false
//    @State var isLoading: Bool = false
//  @State var username: String = "Vijay"
//  @State var avatarUrl: String = "https://d39ii5l128t5ul.cloudfront.net/assets/animals_square/bear.png"
//  @State var joinToken: String = ""
//  @State var stages: [StageDetails] = []
//  @State var isCameraPreviewPresent: Bool = false
//  @State var selectedStage: StageDetails?
//  @State private var isStagePresent: Bool = false
//  @State private var isSetupPresent: Bool = true
//  @State private var isWelcomePresent: Bool = true
//  @Binding var isStagePresentFromReact: Bool
//
  
//  @StateObject private var viewState = ViewState()
     
     // Move state to a separate ObservableObject for better management
//     class ViewState: ObservableObject {
//         @Published var isStageListPresent: Bool = false
//         @Published var isLoading: Bool = false
//         @Published var isStagePresent: Bool = false
//         @Published var isSetupPresent: Bool = true
//         @Published var isWelcomePresent: Bool = true
//         @Published var isCameraPreviewPresent: Bool = false
//         @Published var selectedStage: StageDetails?
//         @Published var stages: [StageDetails] = []
//     }
  
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
          
//          if isSetupPresent {
//              SetupView(isPresent: $isSetupPresent,
//                        isLoading: $isLoading,
//                        isStageListPresent: $isStageListPresent,
//                        onComplete: { (user, token) in
//                  services.viewModel?.clearNotifications()
//                  services.user = user
//
//                  if user.isHost {
//                      services.viewModel?.createStage(user: user) { success in
//                          if success {
//                              services.viewModel?.initializeStage(onComplete: {
//                                  services.viewModel?.joinAsHost() { success in
//                                      if success {
//                                          presentStage()
//                                      }
//                                      isLoading = false
//                                  }
//                              })
//                          } else {
//                              isLoading = false
//                          }
//                      }
//                  } else if let token = token {
//                      services.viewModel?.initializeStage(onComplete: {
//                          services.viewModel?.joinAsParticipant(token) {
//                              presentStage()
//                              isLoading = false
//                          }
//                      })
//                  }
//              })
//          }

          if viewState.isSetupPresent {
              ZStack(alignment: .topLeading) {
                  Color("Background")
                      .edgesIgnoringSafeArea(.all)

                  VStack(alignment: .leading, spacing: 0) {
                      Text("Stages")
                          .modifier(TitleLeading())

                    if !(viewState.stages.first?.stageId.isEmpty ?? false) {
                          Text("All stages")
                              .modifier(TableHeader())
                      }

                      Spacer()

//                      Button(action: {
//                        createStage()
//                      }) {
//                          Text("Create new stage")
//                              .modifier(PrimaryButton())
//                      }
//                      .padding(.top, 5)
                  }

                if viewState.isCameraPreviewPresent, let viewModel = services.viewModel {
                      JoinPreviewView(viewModel: viewModel, isPresent:
                                        $viewState.isCameraPreviewPresent, isLoading: $viewState.isLoading) {
                        guard let stage = viewState.selectedStage else {
                              print("❌ Can't join - no stage selected")
                              return
                          }
                        viewState.isStageListPresent = false
                        joinStage(stage)
                      }
                  }
              }
              .onAppear {
                viewState.isLoading = true
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
        viewState.isLoading = false
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
              services.viewModel?.createStage(user: user) { success in
                  if success {
                      services.viewModel?.initializeStage {
                          services.viewModel?.joinAsHost { success in
                              if success {
                                  presentStage()
                              }
                            viewState.isLoading = false
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
                    viewState.isLoading = false
                  }
              }
          }
      }

  private func presentStage() {
         print("ℹ Before Animation: isStagePresent = \(viewState.isStagePresent)")
         
         DispatchQueue.main.async {
             withAnimation {
                 viewState.isSetupPresent = false
                 viewState.isWelcomePresent = false
                 viewState.isStagePresent = true
             }
             
             DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                 print("ℹ After Animation: isStagePresent = \(viewState.isStagePresent)")
             }
         }
     }
  
  
    private func backAction() {
      viewState.isSetupPresent = true
      viewState.isStageListPresent = true
        withAnimation {
          viewState.isStagePresent = false
        }
      viewState.isLoading = false
    }
}
