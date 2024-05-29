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
    
    func decode(_ data: Data) -> Resource.ModelType? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let decodedData = try? decoder.decode(Resource.ModelType.self, from: data)
        return decodedData
    }

    func execute(withCompletion completion: @escaping (Resource.ModelType?) -> Void) {
        guard let url = resource.url else { return }
        load(url, withCompletion: completion)
    }

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
