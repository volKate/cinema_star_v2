// CatalogScreenView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// View каталога фильмов
struct CatalogScreenView: View {
    private enum Constants {
        static let header = "Смотри исторические\nфильмы на "
        static let logoText = "CINEMA STAR"
    }

    var body: some View {
        BackgroundView {
            VStack {
                headerTextView
                contentView
            }
        }
        .onAppear {
            presenter.fetchCatalog()
        }
    }

    @ViewBuilder
    private var contentView: some View {
        switch presenter.viewState {
        case .initial:
            EmptyView()
        case .loading:
            Text("Loading")
        case .data(let movieCards):
            makeCatalogGridView(movieCards)
        case .noData:
            Text("No data")
        case .error:
            Text("error")
        }
    }

    private var attributedHeaderText: AttributedString {
        var logoText = AttributedString(Constants.logoText)
        logoText.font = .system(size: 20, weight: .heavy)

        return AttributedString(Constants.header) + logoText
    }

    private var headerTextView: some View {
        Text(attributedHeaderText)
            .font(.system(size: 20))
            .padding(.top, 20)
            .padding(.horizontal, 16)
            .padding(.bottom, 14)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    @StateObject var presenter: CatalogPresenter

    private let gridColumns = [
        GridItem(.flexible(), spacing: 18, alignment: .top),
        GridItem(.flexible(), spacing: 18, alignment: .top)
    ]

    private func makeCatalogGridView(_ movieCards: [MovieCard]) -> some View {
        ScrollView {
            LazyVGrid(columns: gridColumns, spacing: 14) {
                ForEach(movieCards, id: \.preview.id) { movie in
                    MovieCardView(
                        posterImage: movie.poster,
                        name: movie.preview.name,
                        rating: movie.preview.rating
                    )
                    .foregroundStyle(.white)
                }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview {
    AppScreenBuilder.stub.build(view: .catalog)
}
