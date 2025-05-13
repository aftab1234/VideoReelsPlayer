//
//  VideoPlayerVM.swift
//  VideoReelsPlayer
//
//  Created by MOHAMMAD AFTAB SABIR on 12/05/25.
//

import SwiftUI
import AVKit
import Combine

import Foundation

@MainActor
class VideoPlayerVM: ObservableObject {
    @Published var videos: [Video] = []

    init() {
        loadVideos()
    }

    func loadVideos() {
        videos = [
            Video(
                title: "Sintel",
                thumbnailURL: URL(string: "https://i.imgur.com/7bMqysJ.jpg")!,
                videoURL: URL(string: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8")!
            ),
            Video(
                title: "MUX Test Stream",
                thumbnailURL: URL(string: "https://i.imgur.com/nq9Fuz2.jpg")!,
                videoURL: URL(string: "https://test-streams.mux.dev/x36xhzz/x36xhzz.m3u8")!
            ),
            Video(
                title: "Elephants Dream",
                thumbnailURL: URL(string: "https://i.imgur.com/yLO9LzR.jpg")!,
                videoURL: URL(string: "https://content.jwplatform.com/manifests/yp34SRmf.m3u8")!
            ),
            Video(
                title: "Subaru Outback Ad",
                thumbnailURL: URL(string: "https://i.imgur.com/47hlTtI.jpg")!,
                videoURL: URL(string: "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8")!
            )
        ]
    }
}

