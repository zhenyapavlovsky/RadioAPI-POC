//
//  ContentView.swift
//  RadioAPI-POC
//
//  Created by Yevhen Pavlovskyy on 29.07.2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ContentViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    radioStationsList
                }
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        toolBarTitle
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
            .sheet(isPresented: $viewModel.isCountryPickerPresented) {
                CountryPickerView(viewModel: viewModel)
            }
        }
        .searchable(text: $viewModel.stationSearchText, prompt: "Search Stations")
    }
}

private extension ContentView {

    private var toolBarTitle: some View {
        HStack {
            Text("Stations List")
                .font(.system(size: 25, weight: .bold))
            Spacer()
            if let selectedCountryId = viewModel.selectedCountryId,
               let selectedCountry = viewModel.countries.first(where: { $0.id == selectedCountryId }) {
                Text(String.countryFlags[selectedCountry.name] ?? "")
                    .font(.system(size: 35))
                    .onTapGesture {
                        viewModel.isCountryPickerPresented.toggle()
                    }
            } else {
                Text("🌍")
                    .font(.system(size: 30))
                    .onTapGesture {
                        viewModel.isCountryPickerPresented.toggle()
                    }
            }
        }
    }

    private var radioStationsList: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.filteredStations) { station in
                    NavigationLink(destination: StationView(viewModel: StationViewModel(station: station))) {
                        createStationRow(station: station)
                    }
                    .padding([.leading, .trailing], 10)
                    .onAppear {
                        if station == viewModel.filteredStations.last && !viewModel.isLoading && viewModel.hasMorePages {
                            viewModel.loadNextPage()
                        }
                    }
                }
                if viewModel.isLoading {
                    ProgressView()
                }
            }
        }
    }

    func createStationRow(station: Station) -> some View {
        HStack(alignment: .top, spacing: 10) {
            AsyncImage(url: station.imageURL) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
                    .frame(width: 50, height: 50)
            }

            VStack(alignment: .leading, spacing: 5) {
                Text(station.title)
                    .font(.headline)
                    .lineLimit(1)

                Text(station.tags.joined(separator: ", "))
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
            .padding(.top, 5)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 1)
    }
}

#Preview {
    ContentView()
}

