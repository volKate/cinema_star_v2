// MockLoadImageService.swift
// Copyright © RoadMap. All rights reserved.

@testable import CinemaStar
import Combine
import Foundation

/// Мок сервиса загрузки изображений
final class MockLoadImageService: LoadImageServiceProtocol {
    private(set) var loadImageCallsWithUrls: [URL] = []

    func load(with url: URL) -> Future<Data, CinemaStar.NetworkError> {
        loadImageCallsWithUrls.append(url)
        return Future { promise in
            promise(.failure(.unknown))
        }
    }
}
