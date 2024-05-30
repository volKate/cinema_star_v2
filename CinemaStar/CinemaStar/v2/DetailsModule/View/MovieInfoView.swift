//
//  MovieInfoView.swift
//  CinemaStar
//
//  Created by Kate Volkova on 30.05.24.
//

import SwiftUI

/// Шапка деталей
struct MovieInfoView: View {
    private enum Constants {
        static let watchButtonText = "Смотреть"
    }

    let movieCard: MovieCard
    let onWatchTap: VoidHandler

    var body: some View {
        contentView
    }

    private var contentView: some View {
        VStack(spacing: 16) {
            HStack(spacing: 16) {
                posterView
                movieInfoView
            }
            .foregroundStyle(.white)

            watchButton
        }
    }

    private var posterView: some View {
        movieCard.poster
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 170, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }

    private var movieInfoView: some View {
        VStack(alignment: .leading) {
            Text(movieCard.preview.name)
                .font(.interBold(ofSize: 18))

            RatingView(movieCard.preview.rating)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var watchButton: some View {
        Button(Constants.watchButtonText, action: onWatchTap)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 14)
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.bgGreen)
            }
            .foregroundStyle(.white)
    }
}

#Preview {
    MovieInfoView(movieCard: MovieCard.createMock(), onWatchTap: {})
}
