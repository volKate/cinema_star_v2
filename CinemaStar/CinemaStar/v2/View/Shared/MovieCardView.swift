//
//  MovieCardView.swift
//  CinemaStar
//
//  Created by Kate Volkova on 27.05.24.
//

import SwiftUI

/// Карточка фильма
struct MovieCardView: View {
    let posterImage: Image
    let name: String
    let rating: Double?

    var body: some View {
        contentView
    }

    private var contentView: some View {
        VStack(alignment: .leading, spacing: 8) {
            posterView
            VStack(alignment: .leading, spacing: 0) {
                nameView

                if let rating {
                    RatingView(rating)
                }
            }
        }
    }

    private var posterView: some View {
        posterImage
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: 250, maxHeight: 200)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    private var nameView: some View {
        Text(name)
    }

    init(posterImage: Image, name: String, rating: Double? = nil) {
        self.posterImage = posterImage
        self.name = name
        self.rating = rating
    }
}

#Preview {
    MovieCardView(
        posterImage: Image(.posterPlaceholder),
        name: "Test name",
        rating: 1.56
    )
}
