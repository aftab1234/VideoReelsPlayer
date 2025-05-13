//
//  ReelsView.swift
//  VideoReelsPlayer
//
//  Created by MOHAMMAD AFTAB SABIR on 13/05/25.
//

import SwiftUI

struct ReelsView: View {
    let videos: [Video]
    @State var currentIndex: Int

    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(videos.indices.reversed(), id: \.self) { index in
                SingleVideoPlayerView(
                    videoURL: videos[index].videoURL,
                    onVideoEnded: {
                        playNextIfAvailable(from: index)
                    }
                )
                .rotationEffect(.degrees(90))
                .frame(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.height
                )
                .tag(index)
            }
        }
        .rotationEffect(.degrees(-90))
        .frame(
            width: UIScreen.main.bounds.height,
            height: UIScreen.main.bounds.width
        )
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .ignoresSafeArea()
    }

    private func playNextIfAvailable(from index: Int) {
        if index + 1 < videos.count {
            currentIndex = index + 1
        }
    }
}










