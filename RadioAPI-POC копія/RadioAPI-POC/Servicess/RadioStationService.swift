//
//  RadioStationService.swift
//  RadioAPI-POC
//
//  Created by Yevhen Pavlovskyy on 30.07.2024.
//

import Foundation
import Combine

protocol RadioStationService {
    func getRadioStations(page: Int) -> AnyPublisher<[Station], Error>
    func getRadioStationsByCountry(countryId: Int, page: Int) -> AnyPublisher<[Station], Error>
    func searchRadioStations(countryId: Int, searchText: String, page: Int) -> AnyPublisher<[Station], Error>
    func getCountries() -> AnyPublisher<[Country], Error>
}

class RadioStationServiceImpl: RadioStationService {

    private let apiManager: APIManager
    private let baseURL = "https://50k-radio-stations.p.rapidapi.com/get"

    init(apiManager: APIManager = APIManagerImpl.sharedInstance) {
        self.apiManager = apiManager
    }

    // Fetches radio stations with pagination
    func getRadioStations(page: Int) -> AnyPublisher<[Station], Error> {
        let urlString = "\(baseURL)/channels?page=\(page)"
        guard let url = URL(string: urlString) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return APIManagerImpl.sharedInstance.request(with: url, method: .get)
            .decode(type: RadioStationsResponse.self, decoder: JSONDecoder())
            .map { $0.toDomainModel() }
            .eraseToAnyPublisher()
    }

    // Fetches radio stations by country with pagination
    func getRadioStationsByCountry(countryId: Int, page: Int) -> AnyPublisher<[Station], Error> {
        let urlString = "\(baseURL)/channels?country_id=\(countryId)&page=\(page)"
        return requestRadioStations(urlString: urlString)
    }

    // Searches for radio stations by country and text with pagination
    func searchRadioStations(countryId: Int, searchText: String, page: Int) -> AnyPublisher<[Station], Error> {
        let encodedSearchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "\(baseURL)/channels?country_id=\(countryId)&search=\(encodedSearchText)&page=\(page)"
        return requestRadioStations(urlString: urlString)
    }

    // Fetches a list of countries
    func getCountries() -> AnyPublisher<[Country], Error> {
        let urlString = "\(baseURL)/countries"
        guard let url = URL(string: urlString) else {
            return Fail(error: UnexpectedError(message: "Invalid URL")).eraseToAnyPublisher()
        }

        return apiManager.request(with: url, method: .get, parameters: nil, headers: nil)
            .tryMap { data -> [Country] in
                if data.isEmpty {
                    throw UnexpectedError(message: "No data received")
                }
                let response = try JSONDecoder().decode(CountriesResponse.self, from: data)
                return response.toDomainModel()
            }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }

    // Helper method to fetch and decode radio stations
    private func requestRadioStations(urlString: String) -> AnyPublisher<[Station], Error> {
        guard let url = URL(string: urlString) else {
            return Fail(error: UnexpectedError(message: "Invalid URL")).eraseToAnyPublisher()
        }

        return apiManager.request(with: url, method: .get, parameters: nil, headers: nil)
            .tryMap { data -> [Station] in
                if data.isEmpty {
                    throw UnexpectedError(message: "No data received")
                }
                let response = try JSONDecoder().decode(RadioStationsResponse.self, from: data)
                return response.toDomainModel()
            }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
