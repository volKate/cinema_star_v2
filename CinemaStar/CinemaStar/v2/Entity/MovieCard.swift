//
//  MovieCard.swift
//  CinemaStar
//
//  Created by Kate Volkova on 29.05.24.
//

import Foundation
import SwiftUI

/// Карточка фильма с постером
struct MovieCard {
    let preview: MoviePreview
    let poster: Image
}

// MARK: - Mock

extension MovieCard {
    static func createMock() -> MovieCard {
        MovieCard(
            preview: MoviePreview.createMock(),
            poster: Image(.posterPlaceholder)
        )
    }
}
