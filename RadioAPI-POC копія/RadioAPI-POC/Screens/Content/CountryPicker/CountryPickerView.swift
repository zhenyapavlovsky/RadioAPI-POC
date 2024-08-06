//
//  CountryPickerView.swift
//  RadioAPI-POC
//
//  Created by Yevhen Pavlovskyy on 02.08.2024.
//

import SwiftUI

struct CountryPickerView: View {

    @ObservedObject var viewModel: ContentViewModel

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                List(viewModel.filteredCountries, id: \.id) { country in
                    Button(action: {
                        viewModel.selectedCountryId = country.id
                        viewModel.isCountryPickerPresented = false
                    }) {
                        HStack {
                            Text(String.countryFlags[country.name] ?? "")
                                .font(.system(size: 30))
                            Text(country.name)
                                .padding()
                        }
                        .padding([.leading, .trailing], 10)
                    }
                }
                .listStyle(PlainListStyle())
                .navigationTitle("Select Country")
                .searchable(text: $viewModel.countrySearchText, prompt: "Search Countries")
            }
        }
    }
}

#Preview {
    CountryPickerView(viewModel: ContentViewModel())
}
