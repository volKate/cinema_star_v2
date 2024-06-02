// MockNetworkService.swift
// Copyright © RoadMap. All rights reserved.

@testable import CinemaStar
import Combine
import Foundation

/// Мок сервиса загрузки данных сети
final class MockNetworkService: NetworkServiceProtocol {
    var shouldResultWithError = false
    let expectedMovies: [MoviePreview] = [MockObjects.mockMoviePreview]
    let expectedMovieDetails: MovieDetails = MockObjects.mockMovieDetails

    func loadMovieDetails(id _: Int) -> Future<CinemaStar.MovieDetails, CinemaStar.NetworkError> {
        Future { [unowned self] promise in
            if shouldResultWithError {
                promise(.failure(.unknown))
            } else {
                promise(.success(expectedMovieDetails))
            }
        }
    }

    func loadMovies() -> Future<[CinemaStar.MoviePreview], CinemaStar.NetworkError> {
        Future { [unowned self] promise in
            if shouldResultWithError {
                promise(.failure(.unknown))
            } else {
                promise(.success(expectedMovies))
            }
        }
    }
}
