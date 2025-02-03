//
//  SetupView.swift
//  AmazonIVSProject
//
//  Created by macmini on 09/01/25.
//

import Foundation
import SwiftUI

struct SetupView: View {
    @EnvironmentObject var services: ServicesManager
    @Binding var isPresent: Bool
    @Binding var isLoading: Bool
    @Binding var isStageListPresent: Bool
    var onComplete: (User, String?) -> Void
    @State var username: String = "Vijay"
    @State var avatarUrl: String = "https://d39ii5l128t5ul.cloudfront.net/assets/animals_square/bear.png"
    @State var joinToken: String = ""

    var body: some View {
      ZStack(alignment: .bottom) {
        
        StageList(isPresent: $isStageListPresent,
                  isLoading: $isLoading,
                  onSelect: joinStage,
                  onCreate: createStage)
        .blur(radius: isLoading ? 3 : 0)
      }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .onDisappear {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .onFirstAppear {
            username = services.user.username ?? "Vijay"
            avatarUrl = services.user.avatarUrl ?? "https://d39ii5l128t5ul.cloudfront.net/assets/animals_square/bear.png"

            checkAVPermissions { granted in
                if !granted {
                    services.viewModel?.appendErrorNotification("No camera/microphone permission granted")
                }
            }
        }
    }

    private func createStage() {
        isLoading = true
        onComplete(updateUser(true), nil)
    }

    private func joinStage(_ stage: StageDetails) {
        isLoading = true
        print("ℹ joining stage: \(stage.stageId)")

        services.viewModel?.getToken(for: stage) { stageJoinResponse, error in
            if let token = stageJoinResponse?.stage.token {
                print("ℹ stage auth successful - got token: \(token)")
                services.server.stageDetails = stage
              print("❌ -------------------------------------------------, \(services.server.stageHostDetails)")
                services.server.joinedStagePlaybackUrl = services.server.stageHostDetails?.channel.playbackUrl ?? ""
                onComplete(updateUser(), stageJoinResponse?.stage.token.token)
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
}

