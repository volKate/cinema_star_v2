// NetworkRequest.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import Foundation

/// Протокол запроса в сеть
protocol NetworkRequest: AnyObject {
    associatedtype ModelType
    /// Метод запуска запроса
    func execute() -> AnyPublisher<ModelType, NetworkError>
}

extension NetworkRequest {
    func load(_ url: URL) -> AnyPublisher<Data, NetworkError> {
        var request = URLRequest(url: url)
        guard let apiToken = try? TokenStorage().getToken() else {
            return Fail(error: NetworkError.unknown).eraseToAnyPublisher()
        }
        request.setValue(apiToken, forHTTPHeaderField: "X-API-KEY")

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse, 200 ... 299 ~= httpResponse.statusCode else {
                    throw NetworkError.responseError
                }

                guard !data.isEmpty else {
                    throw NetworkError.noData
                }

                return data
            }
            .mapError { err in
                if let err = err as? NetworkError {
                    return err
                }
                return NetworkError.unknown
            }
            .eraseToAnyPublisher()
    }
}
