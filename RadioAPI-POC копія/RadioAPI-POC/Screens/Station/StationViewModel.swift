//
//  StationViewModel.swift
//  RadioAPI-POC
//
//  Created by Yevhen Pavlovskyy on 30.07.2024.
//

import Foundation
import Combine

class StationViewModel: ObservableObject {

    @Published var isPlaying = false
    @Published var actualImageSize: CGSize = .zero
    private let radioPlayer: RadioPlayer
    private var cancellables = Set<AnyCancellable>()

    let station: Station

    init(station: Station, radioPlayer: RadioPlayer = RadioPlayer()) {
        self.station = station
        self.radioPlayer = radioPlayer
    }

    func togglePlayback() {
        if isPlaying {
            radioPlayer.pause()
        } else {
            if let url = station.streamURL {
                radioPlayer.play(url: url)
            }
        }
        isPlaying.toggle()
    }

    func updateImageSize(_ size: CGSize) {
        actualImageSize = size
    }
}
