//
//  Video.swift
//  VideoReelsPlayer
//
//  Created by MOHAMMAD AFTAB SABIR on 12/05/25.
//

import Foundation

struct Video: Identifiable {
    let id = UUID()
    let title: String
    let thumbnailURL: URL
    let videoURL: URL
}

