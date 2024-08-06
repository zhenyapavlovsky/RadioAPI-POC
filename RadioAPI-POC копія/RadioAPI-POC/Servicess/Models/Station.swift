//
//  Station.swift
//  RadioAPI-POC
//
//  Created by Yevhen Pavlovskyy on 29.07.2024.
//

import Foundation

struct Station: Identifiable, Equatable {
    var id: UUID
    var title: String
    var imageURL: URL?
    var tags: [String]
    var streamURL: URL?
    var countryId: Int
}

extension RadioStationsResponse: DomainModelConvertible {
    func toDomainModel() -> [Station] {
        return data.map { stationDTO in
            Station(
                id: UUID(),
                title: stationDTO.name,
                imageURL: URL(string: stationDTO.logo?.size600x600 ?? ""),
                tags: stationDTO.genre.map { $0.name },
                streamURL: URL(string: stationDTO.httpsUrl.first?.url ?? ""),
                countryId: stationDTO.countryId
            )
        }
    }
}
