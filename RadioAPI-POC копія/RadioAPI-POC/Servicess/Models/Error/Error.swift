//
//  Error.swift
//  RadioAPI-POC
//
//  Created by Yevhen Pavlovskyy on 30.07.2024.
//

import Foundation

struct ServerError: Codable, Error {
    let code: Int
    let message: String
}
