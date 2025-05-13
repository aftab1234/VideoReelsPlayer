//
//  PlayerVM.swift
//  VideoReelsPlayer
//
//  Created by MOHAMMAD AFTAB SABIR on 13/05/25.
//

import AVKit
import Combine
import Foundation
import SwiftUI

class PlayerVM: ObservableObject {
    @Published var currentTime: Double = 0
    @Published var duration: Double = 1
    @Published var isUserInteracting = false

    private var timeObserver: Any?
    private var statusObserver: NSKeyValueObservation?
    let player: AVPlayer

    init(player: AVPlayer) {
        self.player = player
        addTimeObserver()
        observeItemReadyStatus()
    }

    private func addTimeObserver() {
        timeObserver = player.addPeriodicTimeObserver(
            forInterval: CMTime(seconds: 0.1, preferredTimescale: 600),
            queue: .main
        ) { [weak self] time in
            guard let self = self, !self.isUserInteracting else { return }
            self.currentTime = time.seconds
        }
    }

    private func observeItemReadyStatus() {
        // Observe when the player's currentItem becomes ready to play
        statusObserver = player.observe(\.currentItem?.status, options: [.new, .initial]) { [weak self] player, change in
            guard let self = self else { return }

            if player.currentItem?.status == .readyToPlay {
                self.updateDuration()
            }
        }
    }

    func updateDuration() {
        if let duration = player.currentItem?.duration,
           CMTIME_IS_NUMERIC(duration) {
            self.duration = CMTimeGetSeconds(duration)
        } else {
            self.duration = 1 // fallback
        }
    }

    func seek(to seconds: Double) {
        player.seek(to: CMTime(seconds: seconds, preferredTimescale: 600))
    }

    func pauseUpdates() {
        isUserInteracting = true
    }

    func resumeUpdates() {
        isUserInteracting = false
    }

    deinit {
        if let observer = timeObserver {
            player.removeTimeObserver(observer)
        }
        statusObserver?.invalidate()
    }
}



