//
//  ControlButtonsDrawer.swift
//  AmazonIVSProject
//
//  Created by macmini on 06/01/25.
//

import Foundation
import SwiftUI

struct ControlButtonsDrawer: View {
    @EnvironmentObject var services: ServicesManager
    @ObservedObject var viewModel: StageViewModel
    @Binding var isExpanded: Bool
    @Binding var isChatPresent: Bool

    var body: some View {
        VStack {
            VStack(alignment: .center) {
                Capsule(style: RoundedCornerStyle.circular)
                    .foregroundColor(Color.gray)
                    .frame(width: 20, height: 4)
                    .padding(.vertical, 10)
                    .opacity(services.user.isHost ? 1 : 0)

                HStack(alignment: .top) {
                    ControlButton(image: Image(isChatPresent ? "icon_chat_on" : "icon_chat_off"),
                                  backgroundColor: isChatPresent ? Color("BackgroundButton") : .white) {
                        isChatPresent.toggle()
                    }

                    ControlButton(image: Image(viewModel.localUserAudioMuted ? "icon_mic_off" : "icon_mic_on"),
                                  backgroundColor: viewModel.localUserAudioMuted ? .white : Color("BackgroundButton")) {
                        viewModel.toggleLocalAudioMute()
                    }

                    ControlButton(image: Image(viewModel.localUserVideoMuted ? "icon_video_off" : "icon_video_on"),
                                  backgroundColor: viewModel.localUserVideoMuted ? .white : Color("BackgroundButton")) {
                        viewModel.toggleLocalVideoMute()
                    }

                    ControlButton(image: Image("icon_swap_camera")) {
                        viewModel.swapCamera()
                    }
                }
                .frame(height: 30)
                .padding(.bottom, services.user.isHost ? 0 : 30)

                if services.user.isHost {
                    VStack {
                        Button(action: {
                            viewModel.toggleBroadcasting()
                        }) {
                            Text(viewModel.isBroadcasting ? "Stop Streaming" : "Start Streaming")
                                .modifier(PrimaryButton(color: viewModel.isBroadcasting ? Color("ButtonRed") : Color("Yellow")))
                        }
                    }
                    .padding(.bottom, 5)
                    .padding(.top, 8)
                    .padding(.horizontal, 16)
                }
            }
            .onAppear {
                        print("isHost value:--------------------------------", services.user.isHost)
                    }
            .onChange(of: services.user.isHost) { newValue in
              print("isHost changed to--------------------------------------:", newValue)
          }
            .onReceive(services.user.$isHost) { value in
                        print("ControlButtonsDrawer - isHost updated to:", value)
                    }
            .frame(width: UIScreen.main.bounds.width)
            .background(Color("BackgroundLight"))
            .cornerRadius(30)
            .padding(.top, 10)
        }
//        .gesture(
//            DragGesture()
//                .onEnded({ gesture in
//                    if abs(gesture.translation.height) > 60 {
//                        withAnimation {
//                            if gesture.translation.height > 0 {
//                                isExpanded = false
//                            } else if gesture.translation.height < 0 {
//                                isExpanded = true
//                            }
//                        }
//                    }
//                })
//        )
    }
}

struct ControlButton: View {
    let image: Image
    var color: Color = Color.white
    var backgroundColor = Color("BackgroundButton")
    var size: CGFloat = 40
    let action: () -> Void

    var body: some View {
        Button(action: {
            action()
        }) {
            VStack {
                image
                    .resizable()
                    .padding(8)
                    .background(backgroundColor)
                    .foregroundColor(color)
                    .clipShape(Circle())
                    .frame(width: size, height: size)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
    }
}
