// MockLoadImageService.swift
// Copyright © RoadMap. All rights reserved.

@testable import CinemaStar
import Combine
import Foundation

/// Мок сервиса загрузки изображений
final class MockLoadImageService: LoadImageServiceProtocol {
    private(set) var loadImageCallsWithUrls: [URL] = []

    func load(with url: URL, completion: @escaping (Data?) -> Void) {
        loadImageCallsWithUrls.append(url)
    }

    func load(with url: URL) -> Future<Data, CinemaStar.NetworkError> {
        Future { promise in
            promise(.failure(.unknown))
        }
    }
}
