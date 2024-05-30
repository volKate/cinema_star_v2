// APIRequest.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import Foundation

/// Запрос на сервер за JSON данными
final class APIRequest<Resource: APIResource> {
    let resource: Resource

    init(resource: Resource) {
        self.resource = resource
    }
}

// MARK: - APIRequest + NetworkRequest

extension APIRequest: NetworkRequest {
    func execute() -> AnyPublisher<Resource.ModelType, NetworkError> {
        guard let url = resource.url else {
            return Fail(error: NetworkError.invalidUrl).eraseToAnyPublisher()
        }
        return load(url)
            .decode(type: ModelType.self, decoder: JSONDecoder())
            .mapError { error in
                if error as? DecodingError != nil {
                    return .parsing
                }
                if let networkError = error as? NetworkError {
                    return networkError
                }
                return .unknown
            }
            .eraseToAnyPublisher()
    }
}
