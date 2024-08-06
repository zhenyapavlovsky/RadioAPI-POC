//
//  StationDTO.swift
//  RadioAPI-POC
//
//  Created by Yevhen Pavlovskyy on 30.07.2024.
//

import Foundation

struct StationDTO: Codable {
    let id: Int
    let slug: String
    let name: String
    let cityId: Int
    let countryId: Int
    let logo: LogoDTO?
    let genre: [GenreDTO]
    let streamsUrl: [String]
    let httpsUrl: [StreamURLDTO]

    struct LogoDTO: Codable {
        let size600x600: String?

        private enum CodingKeys: String, CodingKey {
            case size600x600 = "size_600x600"
        }
    }

    struct GenreDTO: Codable {
        let id: Int
        let name: String
    }

    struct StreamURLDTO: Codable {
        let contentType: String
        let isfile: Int
        let codec: String
        let url: String

        private enum CodingKeys: String, CodingKey {
            case contentType = "content_type"
            case isfile
            case codec
            case url
        }
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case slug
        case name
        case cityId = "city_id"
        case countryId = "country_id"
        case logo
        case genre
        case streamsUrl = "streams_url"
        case httpsUrl = "https_url"
    }
}

struct RadioStationsResponse: Codable {
    let success: Bool
    let hasNext: Bool
    let data: [StationDTO]

    private enum CodingKeys: String, CodingKey {
        case success
        case hasNext = "has_next"
        case data
    }
}
