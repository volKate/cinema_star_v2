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
            ScrollView {
                contentView
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden)
    }

    @StateObject var presenter: DetailsPresenter

    private var contentView: some View {
        VStack {
            headerView
            detailsContentView
                .font(.system(size: 14))
        }
    }

    private var detailsContentView: some View {
        VStack(spacing: 16) {
            MovieInfoView(
                movieCard: MovieCard.createMock(),
                onWatchTap: {}
            )
            .padding(.horizontal, 16)
            DescriptionView(
                description: Array(repeating: "This message ", count: 20).joined(),
                releaseInfo: "2"
            )
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            
            ActorsView(actors: ["name LongLast", "name1", "name2", "name3", "name4", "name5", "name6"])

            languageView

            RecommendationsView(movieCards: [MovieCard.createMock()])
        }
    }

    private var headerView: some View {
        NavHeaderView(
            isFavorite: $presenter.isFavorite,
            onBackTap: {
                presenter.goBack()
            }
        )
        .foregroundStyle(.white)
        .padding(.horizontal, 16)
    }

    private var languageView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(Constants.languageTitle)
                .fontWeight(.bold)
                .foregroundStyle(.white)
            Text("blabla")
                .foregroundStyle(.black.opacity(0.41))
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    AppScreenBuilder.stub.build(view: .details(id: 1))
}
