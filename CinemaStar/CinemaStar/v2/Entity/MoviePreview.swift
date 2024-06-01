// MoviePreview.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Превью фильма
struct MoviePreview: Identifiable {
    /// Идентификатор
    let id: Int
    /// Название
    let name: String
    /// Url постера
    let posterUrl: URL?
    /// Рейтинг кинопоиска
    let rating: Double

    init(
        id: Int,
        name: String,
        posterUrl: URL?,
        rating: Double
    ) {
        self.id = id
        self.name = name
        self.posterUrl = posterUrl
        self.rating = rating
    }

    init(fromDTO movieDTO: MoviePreviewDTO) {
        id = movieDTO.id
        name = movieDTO.name
        posterUrl = URL(string: movieDTO.poster.url)
        rating = movieDTO.rating?.kp ?? 0
    }

    init(from movieDetails: MovieDetails) {
        id = movieDetails.id
        name = movieDetails.name
        posterUrl = movieDetails.posterUrl
        rating = movieDetails.rating
    }
}

// MARK: - MoviePreview + Equatable

extension MoviePreview: Equatable {
    static func == (lhs: MoviePreview, rhs: MoviePreview) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Mock

extension MoviePreview {
    private static var mockCount = 0

    static func createMock() -> MoviePreview {
        MoviePreview.mockCount += 1
        return MoviePreview(
            id: mockCount,
            name: "Test name",
            posterUrl: nil,
            rating: 0
        )
    }
}
