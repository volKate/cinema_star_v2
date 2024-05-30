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
        case .data(let movieCards):
            makeCatalogGridView(movieCards)
        case .noData:
            noDataView
        case .error:
            errorView
        }
    }

    private var loadingView: some View {
        makeCatalogGridView(presenter.loadingStubCards, isMock: true)
            .redacted(reason: .placeholder)
            .disabled(true)
            .opacity(isLoadingAnimating ? 1 : 0.2)
            .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: isLoadingAnimating)
            .onAppear {
                isLoadingAnimating = true
            }
            .onDisappear {
                isLoadingAnimating = false
            }
    }

    private var noDataView: some View {
        makeMessageView(
            iconName: "exclamationmark.magnifyingglass",
            message: "Sorry\nNo Data Found"
        )
        .foregroundStyle(.white)
        .frame(maxHeight: .infinity, alignment: .center)
    }

    private var errorView: some View {
        makeMessageView(
            iconName: "exclamationmark.triangle",
            message: "Sorry\nAn error occured",
            retryAction: {
                presenter.fetchCatalog()
            }
        )
        .foregroundStyle(.black)
        .frame(maxHeight: .infinity, alignment: .center)
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
    @State private var isLoadingAnimating = false
    @State private var isLoaded = false

    private let gridColumns = [
        GridItem(.flexible(), spacing: 18, alignment: .top),
        GridItem(.flexible(), spacing: 18, alignment: .top)
    ]

    private func makeCatalogGridView(_ movieCards: [MovieCard], isMock: Bool = false) -> some View {
        ScrollView {
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

    private func makeMessageView(
        iconName: String,
        message: String,
        retryAction: VoidHandler? = nil
    ) -> some View {
        VStack(spacing: 12) {
            Image(systemName: iconName)
                .font(.largeTitle)
            Text(message)
                .multilineTextAlignment(.center)
            if let action = retryAction {
                Button(action: action, label: {
                    Text("Retry")
                        .padding(.vertical, 4)
                        .padding(.horizontal, 12)
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(.black.opacity(0.1))
                        }
                })
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 8)
                .fill(.black.opacity(0.1))
        }
    }
}

#Preview {
    AppScreenBuilder.stub.build(view: .catalog)
}
