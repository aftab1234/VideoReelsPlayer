//
//  HomeView.swift
//  VideoReelsPlayer
//
//  Created by MOHAMMAD AFTAB SABIR on 12/05/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = VideoPlayerVM()

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(Array(viewModel.videos.enumerated()), id: \.element.id) { index, video in
                        NavigationLink {
                            ReelsView(videos: viewModel.videos, currentIndex: index)
                        } label: {
                            VideoThumbnailView(video: video)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .navigationTitle("Videos")
        }
    }
}


