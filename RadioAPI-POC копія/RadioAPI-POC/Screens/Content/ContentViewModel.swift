//
//  ContentViewModel.swift
//  RadioAPI-POC
//
//  Created by Yevhen Pavlovskyy on 30.07.2024.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {

    @Published var stations: [Station] = []
    @Published var stationSearchText: String = ""
    @Published var countrySearchText: String = ""
    @Published var selectedCountryId: Int? {
        didSet {
            resetPagination()
            loadStations()
        }
    }
    @Published var isLoading = false
    @Published var hasMorePages = true
    @Published var countries: [Country] = []
    @Published var isCountryPickerPresented = false

    private let radioStationService: RadioStationService
    private var cancellables = Set<AnyCancellable>()

    private var lastSearchText: String = ""
    private var lastCountryId: Int?
    private var currentPage: Int = 1
    private var stationCache: [String: [Station]] = [:]

    init(radioStationService: RadioStationService = RadioStationServiceImpl()) {
        self.radioStationService = radioStationService
        setupSubscribers()
        loadCountries()
        loadStations()
    }

    private func setupSubscribers() {
        $stationSearchText
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.handleSearchTextChange()
            }
            .store(in: &cancellables)

        $countrySearchText
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.loadCountries()
            }
            .store(in: &cancellables)

        $selectedCountryId
            .sink { [weak self] _ in
                self?.handleCountryIdChange()
            }
            .store(in: &cancellables)
    }

    private func handleSearchTextChange() {
        if lastSearchText != stationSearchText || lastCountryId != selectedCountryId {
            resetPagination()
            lastSearchText = stationSearchText
            loadStations()
        }
    }

    private func handleCountryIdChange() {
        if lastCountryId != selectedCountryId || lastSearchText != stationSearchText {
            resetPagination()
            lastCountryId = selectedCountryId
            loadStations()
        }
    }

    var filteredCountries: [Country] {
        countrySearchText.isEmpty ? countries : countries.filter {
            $0.name.lowercased().contains(countrySearchText.lowercased())
        }
    }

    var filteredStations: [Station] {
        stationSearchText.isEmpty ? stations : stations.filter {
            $0.title.lowercased().contains(stationSearchText.lowercased())
        }
    }

    func loadStations() {
        guard !isLoading && hasMorePages else { return }
        isLoading = true

        let cacheKey = "\(stationSearchText)_\(selectedCountryId ?? -1)_\(currentPage)"
        if let cachedStations = stationCache[cacheKey] {
            handleResult(cachedStations)
            isLoading = false
            return
        }

        let loadStationsPublisher: AnyPublisher<[Station], Error>
        loadStationsPublisher = getStationsPublisher()

        fetchStations(from: loadStationsPublisher, cacheKey: cacheKey)
    }

    private func getStationsPublisher() -> AnyPublisher<[Station], Error> {
        if !stationSearchText.isEmpty {
            return selectedCountryId.map {
                radioStationService.searchRadioStations(countryId: $0, searchText: stationSearchText, page: currentPage)
            } ?? radioStationService.getRadioStations(page: currentPage)
        } else {
            return selectedCountryId.map {
                radioStationService.getRadioStationsByCountry(countryId: $0, page: currentPage)
            } ?? radioStationService.getRadioStations(page: currentPage)
        }
    }

    private func fetchStations(from publisher: AnyPublisher<[Station], Error>, cacheKey: String) {
        publisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    print("Failed to load stations: \(error)")
                }
            } receiveValue: { [weak self] newStations in
                self?.handleResult(newStations)
                self?.stationCache[cacheKey] = newStations
                self?.currentPage += 1
            }
            .store(in: &cancellables)
    }

    func loadCountries() {
        radioStationService.getCountries()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                if case .failure(let error) = completion {
                    print("Failed to load countries: \(error)")
                }
            } receiveValue: { [weak self] countries in
                self?.countries = countries
            }
            .store(in: &cancellables)
    }

    private func handleResult(_ newStations: [Station]) {
        guard !newStations.isEmpty else { return }

        let existingStationIds = Set(stations.map { $0.id })
        let uniqueStations = newStations.filter { !existingStationIds.contains($0.id) }

        if !uniqueStations.isEmpty {
            self.stations.append(contentsOf: uniqueStations)
        }

        self.hasMorePages = !newStations.isEmpty
    }

    func loadNextPage() {
        loadStations()
    }

    private func resetPagination() {
        self.stations.removeAll()
        self.hasMorePages = true
        self.currentPage = 1
        self.stationCache.removeAll()
    }
}
