//
//  APIManager.swift
//  RadioAPI-POC
//
//  Created by Yevhen Pavlovskyy on 30.07.2024.
//

import Foundation
import Alamofire
import Combine

protocol APIManager {
    func request(
        with url: URL,
        method: HTTPMethod,
        parameters: Parameters?,
        headers: HTTPHeaders?
    ) -> AnyPublisher<Data, Error>
}

class APIManagerImpl: APIManager {

    static let sharedInstance = APIManagerImpl()

    private let session: Session

    private init() {
        let configuration = URLSessionConfiguration.default
        let interceptor = RequestInterceptor()
        session = Session(configuration: configuration, interceptor: interceptor)
    }

    func request(
        with url: URL,
        method: HTTPMethod = .get,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil
    ) -> AnyPublisher<Data, Error> {
        session.request(url, method: method, parameters: parameters, encoding: URLEncoding.default, headers: headers)
            .validate()
            .publishData()
            .value()
            .mapError { error in
                print("Request error: \(error.localizedDescription)")
                return error
            }
            .eraseToAnyPublisher()
    }
}
