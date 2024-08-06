//
//  Country.swift
//  RadioAPI-POC
//
//  Created by Yevhen Pavlovskyy on 01.08.2024.
//

import Foundation

struct Country: Identifiable, Equatable {
    var id: Int
    var name: String
}

extension CountriesResponse {
    func toDomainModel() -> [Country] {
        return data.map { countryDTO in
            Country(id: countryDTO.id, name: countryDTO.name)
        }
    }
}
