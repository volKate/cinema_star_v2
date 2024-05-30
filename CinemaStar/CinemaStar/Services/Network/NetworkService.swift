// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import Foundation

/// Протокол сервиса запросов ресурсов
protocol NetworkServiceProtocol {
    /// Метод загрузки деталей о фильме
    func loadMovieDetails(id: Int) -> Future<MovieDetails, NetworkError>
    /// Метод загрузки каталога фильмов
    func loadMovies() -> Future<[MoviePreview], NetworkError>
}

final class NetworkService: NetworkServiceProtocol {
    private var cancellablesSet: Set<AnyCancellable> = []

    func loadMovieDetails(id: Int) -> Future<MovieDetails, NetworkError> {
        Future { [unowned self] promise in
            let resource = MovieDetailsResource(id: id)
            let request = APIRequest(resource: resource)

            request.execute()
                .map {
                    MovieDetails(fromDTO: $0)
                }
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

    func loadMovies() -> Future<[MoviePreview], NetworkError> {
        Future { [unowned self] promise in
            let resource = MoviesResource()
            let request = APIRequest(resource: resource)

            request.execute()
                .map { $0.docs }
                .flatMap { $0.publisher }
                .map { MoviePreview(fromDTO: $0) }
                .collect()
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
