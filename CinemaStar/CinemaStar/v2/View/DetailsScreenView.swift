//
//  DetailsScreenView.swift
//  CinemaStar
//
//  Created by Kate Volkova on 27.05.24.
//

import SwiftUI

/// View деталей о фильме
struct DetailsScreenView: View {
    private enum Constants {
        static let heartImageName = "heart"
        static let heartFillImageName = "heart.fill"
        static let watchButtonText = "Смотреть"
    }

    var body: some View {
        BackgroundView {
            ScrollView {
                VStack {
                    movieInfoView
                    watchButton
                }
                .padding(.horizontal, 16)
            }
        }
    }

    private var movieInfoView: some View {
        HStack(spacing: 16) {
            Image(.posterPlaceholder)
                .frame(width: 170, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading) {
                Text("Movie name")
                    .font(.system(size: 18, weight: .bold))

                RatingView(6.2)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .foregroundStyle(.white)
    }

    private var watchButton: some View {
        Button(Constants.watchButtonText) {}
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
    DetailsScreenView()
}
