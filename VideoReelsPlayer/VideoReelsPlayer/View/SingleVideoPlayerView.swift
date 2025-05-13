//
//  SingleVideoPlayerView.swift
//  VideoReelsPlayer
//
//  Created by MOHAMMAD AFTAB SABIR on 13/05/25.
//

import AVKit
import SwiftUI

struct SingleVideoPlayerView: View {
    let videoURL: URL
    let onVideoEnded: (() -> Void)? // <- callback
    @State private var player = AVPlayer()
    @State private var isPlaying = false
    @Environment(\.scenePhase) var scenePhase

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                VideoPlayerView(player: player)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                    .onAppear {
                        let item = AVPlayerItem(url: videoURL)
                        player.replaceCurrentItem(with: item)
                        player.play()
                        isPlaying = true
                        addLoopOrNextNotification(for: item)
                        
                        // Delay duration update slightly or when item is ready
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                             let observer = SeekBarView(player: player).playerObserver
                             observer.updateDuration()
                        }
                    }
                    .onDisappear {
                        player.pause()
                        isPlaying = false
                        NotificationCenter.default.removeObserver(self)
                    }
                    .onChange(of: scenePhase) { newPhase in
                        switch newPhase {
                        case .active:
                            player.play()
                        case .inactive, .background:
                            player.pause()
                        @unknown default:
                            break
                        }
                    }

                SeekBarView(player: player)
                    .padding(.bottom, 80)
                    .background(Color.white.opacity(0.4))
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.black)
        }
        .edgesIgnoringSafeArea(.all)
    }

    private func addLoopOrNextNotification(for item: AVPlayerItem) {
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: item, queue: .main) { _ in
            onVideoEnded?() // Notify parent (ReelsView)
        }
    }
}





struct VideoPlayerView: UIViewRepresentable {
    let player: AVPlayer

    func makeUIView(context: Context) -> PlayerUIView {
        let view = PlayerUIView()
        view.configure(with: player)
        return view
    }

    func updateUIView(_ uiView: PlayerUIView, context: Context) {
        uiView.updateLayout()
    }
}

class PlayerUIView: UIView {
    private var playerLayer: AVPlayerLayer?

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer?.frame = self.bounds
    }

    func configure(with player: AVPlayer) {
        layer.sublayers?.forEach { $0.removeFromSuperlayer() } // clear old layers
        let layer = AVPlayerLayer(player: player)
        layer.videoGravity = .resizeAspectFill
        layer.frame = self.bounds
        self.layer.addSublayer(layer)
        self.playerLayer = layer
    }

    func updateLayout() {
        playerLayer?.frame = self.bounds
    }
}



