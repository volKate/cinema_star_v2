// MockNetworkService.swift
// Copyright © RoadMap. All rights reserved.

@testable import CinemaStar
import Combine
import Foundation

/// Мок сервиса загрузки данных сети
final class MockNetworkService: NetworkServiceProtocol {
    func loadMovieDetails(id: Int) -> Future<CinemaStar.MovieDetails, CinemaStar.NetworkError> {
        Future { promise in
            promise(.failure(.unknown))
        }
    }
    
    var shouldResultWithError = false
    let expectedMovies: [MoviePreview] = [MockObjects.mockMoviePreview]
    let expectedMovieDetails: MovieDetails = MockObjects.mockMovieDetails

    func loadMovies(completion: @escaping ([MoviePreview]?) -> Void) {
        if shouldResultWithError {
            completion(nil)
            return
        }
        completion(expectedMovies)
    }

    func loadMovies() -> Future<[CinemaStar.MoviePreview], CinemaStar.NetworkError> {
        Future { promise in
            promise(.failure(.unknown))
        }
    }
}
