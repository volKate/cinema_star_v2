// CatalogScreenView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// View каталога фильмов
struct CatalogScreenView: View {
    var body: some View {
        BackgroundView {
            VStack {
                headerTextView
                contentView
            }
            .font(.inter(ofSize: 16))
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .onAppear {
            if !isLoaded {
                presenter.fetchCatalog()
                isLoaded = true
            }
        }
    }

    @ViewBuilder
    private var contentView: some View {
        switch presenter.viewState {
        case .initial:
            EmptyView()
        case .loading:
            loadingView
        case let .data(movieCards):
            ScrollView {
                makeCatalogGridView(movieCards)
            }
        case .noData:
            NoDataMessageView()
        case .error:
            ErrorMessageView()
        }
    }

    private var loadingView: some View {
        ScrollView {
            makeCatalogGridView(presenter.loadingStubCards, isMock: true)
                .redacted(reason: .placeholder)
                .opacity(isLoadingAnimating ? 1 : 0.2)
                .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: isLoadingAnimating)
                .onAppear {
                    isLoadingAnimating = true
                }
                .onDisappear {
                    isLoadingAnimating = false
                }
        }
        .disabled(true)
    }

    private var attributedHeaderText: AttributedString {
        var logoText = AttributedString(Local.Catalog.logo)
        logoText.font = .interBlack(ofSize: 20)

        return AttributedString(Local.Catalog.title) + logoText
    }

    private var headerTextView: some View {
        Text(attributedHeaderText)
            .font(.inter(ofSize: 20))
            .padding(.top, 20)
            .padding(.horizontal, 16)
            .padding(.bottom, 14)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    @StateObject var presenter: CatalogPresenter
    @State private var isLoadingAnimating = false
    @State private var isLoaded = false

    private let gridColumns = [
        GridItem(.flexible(), spacing: 18, alignment: .top),
        GridItem(.flexible(), spacing: 18, alignment: .top),
    ]

    private func makeCatalogGridView(_ movieCards: [MovieCard], isMock: Bool = false) -> some View {
        LazyVGrid(columns: gridColumns, spacing: 14) {
            ForEach(movieCards, id: \.preview.id) { movie in
                MovieCardView(
                    posterImage: movie.poster,
                    name: movie.preview.name,
                    rating: movie.preview.rating
                )
                .foregroundStyle(.white)
                .onTapGesture {
                    if !isMock {
                        presenter.openDetails(id: movie.preview.id)
                    }
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    AppScreenBuilder.stub.build(view: .catalog)
}
