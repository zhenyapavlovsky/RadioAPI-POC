//
//  RequestInterceptor.swift
//  RadioAPI-POC
//
//  Created by Yevhen Pavlovskyy on 30.07.2024.
//

import Foundation
import Alamofire

final class RequestInterceptor: Alamofire.RequestInterceptor {

    private var apiKey: String? {
        return  "de9250a772msh751560b2c8879a5p1f5242jsn9fd308a22a41"
    }

    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard let unwrappedApiKey = self.apiKey else {
            completion(.failure(ServerError(code: 1002, message: "API key not provided")))
            return
        }

        let urlRequest = urlRequest

        let params = [
            "x-rapidapi-key": unwrappedApiKey,
            "x-rapidapi-host": "50k-radio-stations.p.rapidapi.com",
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]

        if let encodedURLRequest = encodeHeaders(params, into: urlRequest) {
            completion(.success(encodedURLRequest))
        } else {
            completion(.failure(ServerError(code: 1002, message: "Failed to encode headers")))
        }
    }

    private func encodeHeaders(_ headers: [String: String], into urlRequest: URLRequest) -> URLRequest? {
        var urlRequest = urlRequest
        for (key, value) in headers {
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        return urlRequest
    }
}
