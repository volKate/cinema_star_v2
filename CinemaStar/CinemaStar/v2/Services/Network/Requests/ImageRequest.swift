// ImageRequest.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import Foundation

/// Запрос на сервер за изображением
final class ImageRequest {
    let url: URL

    init(url: URL) {
        self.url = url
    }
}

// MARK: - ImageRequest + NetworkRequest

extension ImageRequest: NetworkRequest {
    func execute() -> AnyPublisher<Data, NetworkError> {
        load(url)
    }
}
