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
                catalogGridView
            }
        }
        .onAppear {
            presenter.fetchCatalog()
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

    private var catalogGridView: some View {
        ScrollView {
            LazyVGrid(columns: gridColumns, spacing: 14) {
                ForEach(presenter.catalog) { moviePreview in
                    MovieCardView(
                        posterImage: Image(.posterPlaceholder),
                        name: moviePreview.name,
                        rating: moviePreview.rating
                    )
                    .foregroundStyle(.white)
                }
            }
            .padding(.horizontal, 16)
        }
    }

    @StateObject var presenter: CatalogPresenter

    private let gridColumns = [
        GridItem(.flexible(), spacing: 18, alignment: .top),
        GridItem(.flexible(), spacing: 18, alignment: .top)
    ]
}

#Preview {
    AppScreenBuilder.stub.build(view: .catalog)
}
