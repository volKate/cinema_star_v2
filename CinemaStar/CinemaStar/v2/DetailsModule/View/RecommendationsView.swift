//
//  RecommendationsView.swift
//  CinemaStar
//
//  Created by Kate Volkova on 30.05.24.
//

import SwiftUI

/// Рекоммендации похожих фильмов
struct RecommendationsView: View {
    let movieCards: [MovieCard]

    var body: some View {
        contentView
    }

    private var contentView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(Local.Details.Title.recommendations)
                .fontWeight(.bold)
                .padding(.horizontal)
            recommendationsGrid
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundStyle(.white)
    }

    private var recommendationsGrid: some View {
        ScrollView(.horizontal, showsIndicators: false) {
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
        GridItem(.flexible(), spacing: 16, alignment: .top)
    ]
}

#Preview {
    RecommendationsView(movieCards: [MovieCard.createMock()])
}
