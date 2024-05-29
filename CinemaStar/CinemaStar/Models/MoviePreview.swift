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
    /// Рейтинг на кинопоиске
    let kpRating: String
    /// Рейтинг кинопоиска
    let rating: Double

    init(fromDTO movieDTO: MoviePreviewDTO) {
        id = movieDTO.id
        name = movieDTO.name
        posterUrl = URL(string: movieDTO.poster.url)
        if let rating = movieDTO.rating?.kp {
            kpRating = "⭐ \(String(format: "%.1f", rating))"
        } else {
            kpRating = ""
        }
        rating = movieDTO.rating?.kp ?? 0
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
    fileprivate init(
        id: Int,
        name: String,
        posterUrl: URL?,
        kpRating: String,
        rating: Double
    ) {
        self.id = id
        self.name = name
        self.posterUrl = posterUrl
        self.kpRating = kpRating
        self.rating = rating
    }
    
    private static var mockCount = 0

    static func createMock() -> MoviePreview {
        MoviePreview.mockCount += 1
        return MoviePreview(
            id: mockCount,
            name: "",
            posterUrl: nil,
            kpRating: "",
            rating: 0
        )
    }
}
