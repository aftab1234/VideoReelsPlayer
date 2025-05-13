//
//  VideoThumbnailView.swift
//  VideoReelsPlayer
//
//  Created by MOHAMMAD AFTAB SABIR on 12/05/25.
//

import SwiftUI

struct VideoThumbnailView: View {
    let video: Video

    var body: some View {
        VStack {
            AsyncImage(url: video.thumbnailURL) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(height: 300)
            .clipped()

            Text(video.title)
                .font(.headline)
                .padding([.top, .bottom], 8)
        }
        .padding(.horizontal)
    }
}

