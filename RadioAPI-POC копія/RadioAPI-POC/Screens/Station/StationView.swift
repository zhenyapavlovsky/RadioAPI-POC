//
//  StationView.swift
//  RadioAPI-POC
//
//  Created by Yevhen Pavlovskyy on 29.07.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct StationView: View {

    @StateObject var viewModel: StationViewModel

    var body: some View {
        VStack {
            if let url = viewModel.station.imageURL {
                WebImage(url: url)
                    .onSuccess { image, _, _ in
                        DispatchQueue.main.async {
                            viewModel.updateImageSize(image.size)
                        }
                    }
                    .resizable()
                    .frame(width: 300, height: 300)
                    .aspectRatio(contentMode: .fill)
                    .padding(16)
            } else {
                Text("Image URL is invalid")
            }

            if viewModel.actualImageSize != .zero {
                imageSizeLabel
            }

            playPauseButton
        }
        .padding()
    }
}

private extension StationView {
    var playPauseButton: some View {
        HStack {
            Button(action: {
                viewModel.togglePlayback()
            }) {
                Image(systemName: viewModel.isPlaying ? "pause.circle.fill" : "play.circle.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.secondary)
            }
            .padding()
        }
    }

    var imageSizeLabel: some View {
        Text("Width: \(Int(viewModel.actualImageSize.width)) px, Height: \(Int(viewModel.actualImageSize.height)) px")
            .font(.system(size: 15, weight: .bold))
            .foregroundColor(.black)
            .padding()
    }
}
