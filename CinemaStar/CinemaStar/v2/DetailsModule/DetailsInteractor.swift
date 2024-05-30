//
//  DetailsInteractor.swift
//  CinemaStar
//
//  Created by Kate Volkova on 30.05.24.
//

import Combine
import Foundation
import SwiftUI

/// Интерактор деталей
final class DetailsInteractor {
    private let networkService: NetworkServiceProtocol
    private let loadImageService: LoadImageServiceProtocol
    private let storageService: Storage

    init(
        networkService: NetworkServiceProtocol,
        loadImageService: LoadImageServiceProtocol,
        storageService: Storage
    ) {
        self.networkService = networkService
        self.loadImageService = loadImageService
        self.storageService = storageService
    }

    func getIsFavorite(id: Int) throws -> Bool {
        try storageService.value(forKey: String(id))
    }

    func saveFavorite(isFavorite: Bool, id: Int) throws {
        try storageService.save(isFavorite, forKey: String(id))
    }

    func fetchDetails(id: Int) -> AnyPublisher<MovieDetailsViewData, NetworkError> {
        fetch(id: id)
    }

    private func fetch(id: Int) -> AnyPublisher<MovieDetailsViewData, NetworkError> {
        networkService.loadMovieDetails(id: id)
            .flatMap { movieDetails in
                movieDetails.actors.publisher
                    .flatMap { [unowned self] actor in
                        fetchImage(actor.photoUrl)
                            .map {
                                ActorCard(name: actor.name, photo: $0)
                            }
                            .eraseToAnyPublisher()
                    }
                    .collect()
                    .flatMap { [unowned self] actors in
                        fetchSimilarMovies(movieDetails.similarMovies ?? [])
                            .flatMap { [unowned self] similarMovies in
                                fetchImage(movieDetails.posterUrl)
                                    .map {
                                        MovieDetailsViewData(
                                            movieDetails: movieDetails,
                                            similarMovies: similarMovies,
                                            poster: $0,
                                            actors: actors
                                        )
                                    }
                                    .eraseToAnyPublisher()
                            }
                    }
            }
            .eraseToAnyPublisher()
    }

    private func fetchSimilarMovies(_ movies: [MoviePreview]) -> AnyPublisher<[MovieCard], NetworkError> {
        movies.publisher
            .flatMap { [unowned self] moviePreview in
                fetchImage(moviePreview.posterUrl)
                    .map {
                        MovieCard(preview: moviePreview, poster: $0)
                    }
                    .eraseToAnyPublisher()
            }
            .collect()
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }

    private func fetchImage(_ imageUrl: URL?) -> AnyPublisher<Image, Never> {
        guard let imageUrl else {
            return Just(Image(.posterPlaceholder))
                .eraseToAnyPublisher()
        }

        return loadImageService.load(with: imageUrl)
            .tryMap { data in
                guard let uiImage = UIImage(data: data) else {
                    throw NetworkError.unknown
                }
                return Image(uiImage: uiImage)
            }
            .replaceError(with: Image(.posterPlaceholder))
            .eraseToAnyPublisher()
    }
}
