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

struct AmazonIVSBroadcastView: View {
    @ObservedObject var services = ServicesManager()
    @State var isWelcomePresent: Bool = true
    @State var isSetupPresent: Bool = true
    @State var isStageListPresent: Bool = false
    @State var isStagePresent: Bool = false
    @State var isLoading: Bool = false
  @State var username: String = "Vijay"
  @State var avatarUrl: String = "https://d39ii5l128t5ul.cloudfront.net/assets/animals_square/bear.png"
  @State var joinToken: String = ""
  @State var stages: [StageDetails] = []
  @State var isCameraPreviewPresent: Bool = false
  @State var selectedStage: StageDetails?
  
  
    var body: some View {
        ZStack(alignment: .top) {
            Color("Background")
                .edgesIgnoringSafeArea(.all)

            if isStagePresent, let viewModel = services.viewModel {
                StageView(viewModel: viewModel,
                          chatModel: services.chatModel,
                          isPresent: $isStagePresent,
                          isLoading: $isLoading,
                          backAction: backAction)
                    .transition(.slide)
            }
          
          if isSetupPresent {
              SetupView(isPresent: $isSetupPresent,
                        isLoading: $isLoading,
                        isStageListPresent: $isStageListPresent,
                        onComplete: { (user, token) in
                  services.viewModel?.clearNotifications()
                  services.user = user

                  if user.isHost {
                      services.viewModel?.createStage(user: user) { success in
                          if success {
                              services.viewModel?.initializeStage(onComplete: {
                                  services.viewModel?.joinAsHost() { success in
                                      if success {
                                          presentStage()
                                      }
                                      isLoading = false
                                  }
                              })
                          } else {
                              isLoading = false
                          }
                      }
                  } else if let token = token {
                      services.viewModel?.initializeStage(onComplete: {
                          services.viewModel?.joinAsParticipant(token) {
                              presentStage()
                              isLoading = false
                          }
                      })
                  }
              })
          }

//            if isSetupPresent {
//              ZStack(alignment: .topLeading) {
//                  Color("Background")
//                      .edgesIgnoringSafeArea(.all)
//
//                  VStack(alignment: .leading, spacing: 0) {
//                      Text("Stages")
//                          .modifier(TitleLeading())
//
//                      if !(stages.first?.stageId.isEmpty ?? false) {
//                          Text("All stages")
//                              .modifier(TableHeader())
//                      }
//
//                      Spacer()
//
//                      Button(action: {
//                        createStage()
//                      }) {
//                          Text("Create new stage")
//                              .modifier(PrimaryButton())
//                      }
//                      .padding(.top, 5)
//                  }
//
//                  if isCameraPreviewPresent, let viewModel = services.viewModel {
//                      JoinPreviewView(viewModel: viewModel, isPresent: $isCameraPreviewPresent, isLoading: $isLoading) {
//                          guard let stage = selectedStage else {
//                              print("❌ Can't join - no stage selected")
//                              return
//                          }
//                        isStageListPresent = false
//                        joinStage(stage)
//                      }
//                  }
//              }
//              .onAppear {
//                  isLoading = true
//                  DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                      services.viewModel?.getAllStages(initial: true) { allStages in
//                          stages = allStages
//                          isLoading = false
//                      }
//                  }
//              }
//          }



            if let viewModel = services.viewModel {
                NotificationsView(viewModel: viewModel)
            }

            if isLoading {
                ActivityIndicator()
            }
        }
        .environmentObject(services)
    }
  
  private func createStage() {
      isLoading = true
    handleSetupCompletion(user: updateUser(true), token: nil)
  }

  private func joinStage(_ stage: StageDetails) {
      isLoading = true
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
          isLoading = false
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
                            isLoading = false
                        }
                    }
                } else {
                    isLoading = false
                }
            }
        } else if let token = token {
            services.viewModel?.initializeStage {
                services.viewModel?.joinAsParticipant(token) {
                    presentStage()
                    isLoading = false
                }
            }
        }
    }

    private func presentStage() {
        withAnimation {
            isStagePresent = true
        }
        isSetupPresent = false
        isWelcomePresent = false
    }

    private func backAction() {
        isSetupPresent = true
        isStageListPresent = true
        withAnimation {
            isStagePresent = false
        }
        isLoading = false
    }
}
