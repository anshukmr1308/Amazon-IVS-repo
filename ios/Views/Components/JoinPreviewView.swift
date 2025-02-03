//
//  JoinPreviewView.swift
//  Multihost
//
//  Created by Uldis Zingis on 08/08/2022.
//

import SwiftUI

struct JoinPreviewView: View {
    @EnvironmentObject var services: ServicesManager
    @ObservedObject var viewModel: StageViewModel
    @Binding var isPresent: Bool
    @Binding var isLoading: Bool
    @Binding var isPreviewActive: Bool
    let onJoin: () -> Void

//    @State var isPreviewActive: Bool = true
    @State var isFrontCameraActive: Bool = true

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.6)
                    .frame(
                      height: geometry.size.height * 0.5
                    )


                VStack(spacing: 8) {
                    Text("This is how you'll look and sound")
                        .modifier(Description())
                        .padding(13)

                    CameraView(isPreviewActive: $isPreviewActive, isFrontCameraActive: $isFrontCameraActive)
                        .frame(width: geometry.size.width - 16, height: 180)
                        .scaledToFit()
                        .overlay {
                            ZStack {
                                Color("BackgroundGray")
                                    .cornerRadius(20)

                                VStack(spacing: 0) {
                                    RemoteImageView(imageURL: services.user.avatarUrl ?? "")
                                        .frame(width: 30, height: 30)
                                        .clipShape(Circle())
                                    Text(services.user.username ?? "")
                                        .modifier(TitleRegular())
                                }
                            }
                            .opacity(viewModel.localUserVideoMuted ? 1 : 0)
                            .transition(.opacity.animation(.easeInOut))
                        }
                        .background(Color.black)
                        .cornerRadius(25)
                        .padding(.horizontal, 8)
                        .onAppear {
                            isFrontCameraActive = viewModel.selectedCamera?.position == .front
                        }

                    HStack(spacing: 24) {
                        Spacer()
                        ControlButton(image: Image(viewModel.localUserAudioMuted ? "icon_mic_off" : "icon_mic_on"),
                                      backgroundColor: viewModel.localUserAudioMuted ? .white : Color("BackgroundButton")) {
                            viewModel.toggleLocalAudioMute()
                        }
//                        .frame(maxWidth: 30)

                        ControlButton(image: Image(viewModel.localUserVideoMuted ? "icon_video_off" : "icon_video_on"),
                                      backgroundColor: viewModel.localUserVideoMuted ? .white : Color("BackgroundButton")) {
                            withAnimation {
                                viewModel.toggleLocalVideoMute()
                            }
                        }
//                        .frame(maxWidth: 30)

                        ControlButton(image: Image("icon_swap_camera")) {
                            viewModel.swapCamera()
                            isFrontCameraActive = !isFrontCameraActive
                        }
//                        .frame(maxWidth: 30)
                        Spacer()
                    }
                    .background(Color("BackgroundList"))
                    .cornerRadius(20)
                    .padding(.horizontal, 8)
                  

//                    HStack {
//                        Button(action: {
//                            isPresent.toggle()
//                        }) {
//                            Text("Cancel")
//                                .modifier(ActionButton())
//                        }
//
//                        Button(action: {
//                            isLoading = true
//                            isPreviewActive = false
//
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                                self.onJoin()
//                                self.isPresent.toggle()
//                            }
//                        }) {
//                            Text("Join")
//                                .modifier(ActionButton(color: .black, background: Color("Yellow")))
//                        }
//                    }
//                    .padding(.horizontal, 16)
                }
                .padding(.bottom, 15)
                .background(Color("BackgroundLight"))
                .cornerRadius(15)
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .onAppear {
          BroadcastEventEmitter.shared?.emitBroadcastDisappearEvent()
          BroadcastEventEmitter.shared?.emitPreviewPageState(true)
            isPreviewActive = true
        }
    }
  
  func handleCancel() {
          BroadcastEventEmitter.shared?.emitBroadcastAppearEvent()
    BroadcastEventEmitter.shared?.emitPreviewPageState(false)
          isPresent.toggle()
      }
      
      func handleJoin() {
          isLoading = true
          isPreviewActive = false
        BroadcastEventEmitter.shared?.emitPreviewPageState(false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
          self.onJoin()
          self.isPresent.toggle()
        }
      }
}
