// MockObjects.swift
// Copyright © RoadMap. All rights reserved.

@testable import CinemaStar
import Foundation

/// Моковые объекты данных
enum MockObjects {
    static let mockMoviePreview = MoviePreview(
        fromDTO: MoviePreviewDTO(
            id: 1,
            name: "mock",
            poster: PosterDTO(
                url: "poster_url"
            ),
            rating: RatingDTO(
                kp: 3.5
            )
        )
    )

    static let mockMovieDetails = MovieDetails(
        fromDTO: MovieDetailsDTO(
            id: 2,
            name: "mock",
            poster: PosterDTO(
                url: "poster_url"
            ),
            rating: RatingDTO(
                kp: 3.5
            ),
            description: "mock_description",
            year: 2000,
            countries: [CountryDTO(name: "mock_country_name")],
            type: "tv_series",
            persons: [
                PersonDTO(
                    id: 1,
                    photo: "actor_photo_url",
                    name: "actor_name",
                    enName: ""
                )
            ],
            spokenLanguages: [LanguageDTO(name: "mock_language_name")],
            similarMovies: [
                MoviePreviewDTO(
                    id: 3,
                    name: "mock_recommendation",
                    poster: PosterDTO(
                        url: "recommendation_poster_url"
                    ),
                    rating: RatingDTO(
                        kp: 3.5
                    )
                )
            ]
        )
    )
}
