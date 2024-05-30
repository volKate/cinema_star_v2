//
//  RecommendationsView.swift
//  CinemaStar
//
//  Created by Kate Volkova on 30.05.24.
//

import SwiftUI

/// Рекоммендации похожих фильмов
struct RecommendationsView: View {
    private enum Constants {
        static let recommendationsTitle = "Смотрите также"
    }

    let movieCards: [MovieCard]

    var body: some View {
        contentView
    }

    private var contentView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Constants.recommendationsTitle)
                .fontWeight(.bold)
                .padding(.horizontal)
            recommendationsGrid
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundStyle(.white)
    }

    private var recommendationsGrid: some View {
        ScrollView {
            LazyHGrid(rows: gridRows) {
                ForEach(movieCards, id: \.preview.id) { movieCard in
                    MovieCardView(
                        posterImage: movieCard.poster,
                        name: movieCard.preview.name
                    )
                    .frame(width: 170)
                }
            }
            .padding(.horizontal)
        }
    }

    private let gridRows = [
        GridItem(.flexible(), spacing: 16)
    ]
}

#Preview {
    RecommendationsView(movieCards: [MovieCard.createMock()])
}
