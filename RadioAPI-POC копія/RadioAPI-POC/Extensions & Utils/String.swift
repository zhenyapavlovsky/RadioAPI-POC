//
//  String.swift
//  RadioAPI-POC
//
//  Created by Yevhen Pavlovskyy on 02.08.2024.
//

import Foundation

extension String {
    static let countryFlags: [String: String] = [
        "Saint Kitts and Nevis": "🇰🇳",
        "United Arab Emirates": "🇦🇪",
        "Belgium": "🇧🇪",
        "United States": "🇺🇸",
        "Cayman Islands": "🇰🇾",
        "France": "🇫🇷",
        "Haiti": "🇭🇹",
        "Australia": "🇦🇺",
        "Italy": "🇮🇹",
        "Mexico": "🇲🇽",
        "Spain": "🇪🇸",
        "Brazil": "🇧🇷",
        "Morocco": "🇲🇦",
        "Greece": "🇬🇷",
        "Ukraine": "🇺🇦",
        "Russia": "🇷🇺",
        "Germany": "🇩🇪",
        "Philippines": "🇵🇭",
        "Netherlands": "🇳🇱",
        "Poland": "🇵🇱",
        "Algeria": "🇩🇿",
        "South Africa": "🇿🇦",
        "Serbia": "🇷🇸",
        "Zimbabwe": "🇿🇲",
        "Czech Republic": "🇨🇿",
        "Switzerland": "🇨🇭",
        "Georgia": "🇬🇪",
        "Romania": "🇷🇴",
        "Uruguay": "🇺🇾",
        "Lesser Antilles, France": "🇫🇷"
    ]

    var countryFlag: String {
        return String.countryFlags[self] ?? ""
    }
}
