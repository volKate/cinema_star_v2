// NetworkService.swift
// Copyright © RoadMap. All rights reserved.

import Combine
import Foundation

/// Протокол сервиса запросов ресурсов
protocol NetworkServiceProtocol {
    /// Метод загрузки деталей о фильме
    func loadMovieDetails(id: Int, completion: @escaping (MovieDetails?) -> Void)
    /// Метод загрузки каталога фильмов
    func loadMovies() -> Future<[MoviePreview], NetworkError>
}

final class NetworkService: NetworkServiceProtocol {
    private var cancellablesSet: Set<AnyCancellable> = []

    func loadMovieDetails(id: Int, completion: @escaping (MovieDetails?) -> Void) {
        let resource = MovieDetailsResource(id: id)
        let request = APIRequest(resource: resource)

        request.execute { movieDetailsDTO in
            _ = request
            DispatchQueue.main.async {
                guard let movieDetailsDTO else {
                    completion(nil)
                    return
                }
                let movieDetails = MovieDetails(fromDTO: movieDetailsDTO)
                completion(movieDetails)
            }
        }
    }

    func loadMovies() -> Future<[MoviePreview], NetworkError> {
        return Future { promise in
            let resource = MoviesResource()
            let request = APIRequest(resource: resource)

            request.execute { moviesDTO in
                _ = request
                DispatchQueue.main.async {
                    guard let moviesDTO else {
                        promise(.failure(.noData))
                        return
                    }
                    let moviePreviews = moviesDTO.docs.map { MoviePreview(fromDTO: $0) }
                    promise(.success(moviePreviews))
                }
            }
        }
    }
}
