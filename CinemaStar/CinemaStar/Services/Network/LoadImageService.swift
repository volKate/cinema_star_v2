// LoadImageService.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import Foundation

/// Протокол сервиса загрузки изображений
protocol LoadImageServiceProtocol {
    /// Метод загрузки изображения
    func load(with url: URL) -> Future<Data, NetworkError>
}

/// Сервис загрузки изображений
final class LoadImageService: LoadImageServiceProtocol {
    private var cancellablesSet: Set<AnyCancellable> = []

    func load(with url: URL) -> Future<Data, NetworkError> {
        Future { [unowned self] promise in
            let request = ImageRequest(url: url)
            request.execute()
                .sink { completion in
                    if case let .failure(err)  = completion {
                        promise(.failure(err))
                    }
                } receiveValue: { data in
                    promise(.success(data))
                }
                .store(in: &cancellablesSet)
        }
    }
}

/// Прокси для получения и кэширования изображений
final class LoadImageProxy: LoadImageServiceProtocol {
    private var cancellablesSet: Set<AnyCancellable> = []
    private var service: LoadImageServiceProtocol

    init(service: LoadImageServiceProtocol) {
        self.service = service
    }

    func load(with url: URL) -> Future<Data, NetworkError> {
        Future { [unowned self] promise in
            let fileManager = FileManager.default
            guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
            else {
                return promise(.failure(.unknown))
            }

            let stringHash = String(url.relativePath.split(separator: "/").joined())
            let imageUrl = documentsDirectory.appendingPathComponent(stringHash)
            if fileManager.fileExists(atPath: imageUrl.path) {
                guard let imageData = try? Data(contentsOf: imageUrl) else {
                    return promise(.failure(.noData))
                }
                promise(.success(imageData))
            } else {
                service.load(with: url)
                    .sink { completion in
                        if case let .failure(err) = completion {
                            promise(.failure(err))
                        }
                    } receiveValue: { data in
                        promise(.success(data))
                        do {
                            try data.write(to: imageUrl)
                        } catch {
                            print("error saving")
                        }
                    }
                    .store(in: &cancellablesSet)
            }
        }
    }
}
