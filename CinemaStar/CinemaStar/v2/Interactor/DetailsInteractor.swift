//
//  DetailsInteractor.swift
//  CinemaStar
//
//  Created by Kate Volkova on 30.05.24.
//

import Combine
import Foundation
import SwiftUI

/// Интерактор каталога
final class DetailsInteractor {
    private let networkService: NetworkServiceProtocol
    private let loadImageService: LoadImageServiceProtocol

    init(
        networkService: NetworkServiceProtocol,
        loadImageService: LoadImageServiceProtocol
    ) {
        self.networkService = networkService
        self.loadImageService = loadImageService
    }

//    func fetchCatalog() -> AnyPublisher<[MovieCard], NetworkError> {
//        fetchMovies()
//    }
//
//    private func fetchPoster(_ posterUrl: URL?) -> AnyPublisher<Image, Never> {
//        guard let posterUrl else {
//            return Just(Image(.posterPlaceholder))
//                .eraseToAnyPublisher()
//        }
//
//        return loadImageService.load(with: posterUrl)
//            .tryMap { data in
//                guard let uiImage = UIImage(data: data) else {
//                    throw NetworkError.unknown
//                }
//                return Image(uiImage: uiImage)
//            }
//            .replaceError(with: Image(.posterPlaceholder))
//            .eraseToAnyPublisher()
//
//    }
//
//    private func fetchMovies() -> AnyPublisher<[MovieCard], NetworkError> {
//        networkService.loadMovies()
//            .flatMap { $0.publisher }
//            .flatMap { [unowned self] moviePreview in
//                fetchPoster(moviePreview.posterUrl)
//                    .map {
//                        MovieCard(preview: moviePreview, poster: $0)
//                    }
//                    .eraseToAnyPublisher()
//            }
//            .collect()
//            .eraseToAnyPublisher()
//    }
}
