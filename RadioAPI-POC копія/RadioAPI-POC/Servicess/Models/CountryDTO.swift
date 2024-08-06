//
//  CountryDTO.swift
//  RadioAPI-POC
//
//  Created by Yevhen Pavlovskyy on 05.08.2024.
//

import Foundation

struct CountryDTO: Codable {
    let id: Int
    let name: String
}

struct CountriesResponse: Codable {
    let success: Bool
    let hasNext: Bool
    let data: [CountryDTO]

    private enum CodingKeys: String, CodingKey {
        case success
        case hasNext = "has_next"
        case data
    }
}
