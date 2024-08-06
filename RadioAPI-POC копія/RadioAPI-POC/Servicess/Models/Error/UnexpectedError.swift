//
//  UnexpectedError.swift
//  RadioAPI-POC
//
//  Created by Yevhen Pavlovskyy on 30.07.2024.
//

import Foundation

struct UnexpectedError: Error {
    let message: String

    init(message: String = "An unexpected error occurred") {
        self.message = message
    }
}
