//
//  SeekBarView.swift
//  VideoReelsPlayer
//
//  Created by MOHAMMAD AFTAB SABIR on 13/05/25.
//

import AVFoundation
import SwiftUI

struct SeekBarView: View {
    @ObservedObject var playerObserver: PlayerVM

    init(player: AVPlayer) {
        playerObserver = PlayerVM(player: player)
    }

    var body: some View {
        Slider(value: $playerObserver.currentTime, in: 0...playerObserver.duration, onEditingChanged: { editing in
            if !editing {
                playerObserver.seek(to: playerObserver.currentTime)
            }
        })
        .accentColor(.white)
        .padding(.horizontal)
    }
}


