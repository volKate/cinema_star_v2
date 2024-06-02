//
//  DetailsScreenView.swift
//  CinemaStar
//
//  Created by Kate Volkova on 29.05.24.
//

import SwiftUI

/// View деталей о фильме
struct DetailsScreenView: View {
    var body: some View {
        BackgroundView {
            contentView
                .font(.inter(ofSize: 16))
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
            case let .data(movieDetails):
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
                    onWatchTap: {
                        presenter.watch()
                    }
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
            .font(.inter(ofSize: 14))
        }
    }

    private func makeLanguageView(_ language: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(Local.Details.Title.language)
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
