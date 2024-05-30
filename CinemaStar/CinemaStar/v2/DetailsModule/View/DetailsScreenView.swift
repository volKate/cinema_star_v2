//
//  DetailsScreenView.swift
//  CinemaStar
//
//  Created by Kate Volkova on 29.05.24.
//

import SwiftUI

/// View деталей о фильме
struct DetailsScreenView: View {
    private enum Constants {
        static let languageTitle = "Язык"
    }

    var body: some View {
        BackgroundView {
            contentView
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden)
        .onAppear {
            presenter.fetchDetails()
        }
    }

    @StateObject var presenter: DetailsPresenter

    private var contentView: some View {
        VStack {
            headerView

            switch presenter.viewState {
            case .initial:
                EmptyView()
            case .loading:
                DetailsShimmerView()
            case .data(let movieDetails):
                makeDetailsContentView(movieDetails)
            case .noData:
                NoDataMessageView()
            case .error:
                ErrorMessageView()
            }
        }
    }

    private var headerView: some View {
        NavHeaderView(
            isFavorite: presenter.isFavorite,
            onBackTap: {
                presenter.goBack()
            }, onHeartTap: {
                presenter.toggleIsFavorite()
            }
        )
        .foregroundStyle(.white)
        .padding(.horizontal, 16)
    }

    private func makeDetailsContentView(_ viewData: MovieDetailsViewData) -> some View {
        ScrollView {
            VStack(spacing: 16) {
                MovieInfoView(
                    movieCard: MovieCard(
                        preview: MoviePreview(from: viewData.movieDetails),
                        poster: viewData.poster
                    ),
                    onWatchTap: {}
                )
                .padding(.horizontal, 16)
                DescriptionView(
                    description: viewData.movieDetails.description,
                    releaseInfo: viewData.movieDetails.releaseInfo
                )
                .foregroundStyle(.white)
                .padding(.horizontal, 16)

                ActorsView(actors: viewData.actors)

                if let language = viewData.movieDetails.language {
                    makeLanguageView(language)
                }

                if !viewData.similarMovies.isEmpty {
                    RecommendationsView(movieCards: viewData.similarMovies)
                }
            }
            .font(.system(size: 14))
        }
    }

    private func makeLanguageView(_ language: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(Constants.languageTitle)
                .fontWeight(.bold)
                .foregroundStyle(.white)
            Text(language)
                .foregroundStyle(.black.opacity(0.41))
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    AppScreenBuilder.stub.build(view: .details(id: 1))
}
