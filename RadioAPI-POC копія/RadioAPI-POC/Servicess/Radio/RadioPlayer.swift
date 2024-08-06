//
//  RadioPlayer.swift
//  RadioAPI-POC
//
//  Created by Yevhen Pavlovskyy on 31.07.2024.
//

import Foundation
import AVFoundation

class RadioPlayer: ObservableObject {

    private var player: AVPlayer?

    func play(url: URL) {
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        player?.play()
    }

    func pause() {
        player?.pause()
    }
}
