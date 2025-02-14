import SwiftUI
import AVKit
import AmazonIVSBroadcast

struct ParticipantView: View {
    @EnvironmentObject var services: ServicesManager
    var preview: IVSImagePreviewView?
    weak var audioDevice: IVSAudioDevice?
    @ObservedObject var participant: ParticipantData

    var body: some View {
        ZStack(alignment: .bottom) {
            if let preview = preview {
                IVSImagePreviewViewWrapper(previewView: preview)
            }

            if participant.videoMuted || (participant.isLocal && services.viewModel?.localUserVideoMuted ?? false) {
                ZStack {
                    Color("BackgroundGray")
                        .cornerRadius(40)

                    VStack(spacing: 4) {
                        RemoteImageView(imageURL: participant.avatarUrl)
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())

                        Text(participant.username)
                            .modifier(TitleRegular())
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .background(Color("BackgroundList"))
    }
}
