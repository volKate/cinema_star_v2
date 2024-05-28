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
                // TODO: replace with real data
                ForEach(0..<10) { _ in
                    MovieCardView(
                        posterImage: Image(.posterPlaceholder),
                        name: "Movie 64",
                        rating: 6.8
                    )
                    .foregroundStyle(.white)
                }
            }
            .padding(.horizontal, 16)
        }
    }

    @StateObject var presenter: CatalogPresenter

    private let gridColumns = [
        GridItem(.flexible(), spacing: 18),
        GridItem(.flexible(), spacing: 18)
    ]
}

#Preview {
    AppScreenBuilder.stub.build(view: .catalog)
}
