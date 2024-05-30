//
//  NavHeaderView.swift
//  CinemaStar
//
//  Created by Kate Volkova on 30.05.24.
//

import SwiftUI

/// Кастомная навигация экрана деталей
struct NavHeaderView: View {
    private enum Constants {
        static let backIconName = "chevron.left"
        static let heartImageName = "heart"
        static let heartFillImageName = "heart.fill"
        static let watchButtonText = "Смотреть"
    }

    var body: some View {
        HStack {
            Button(action: onBackTap) {
                Image(systemName: Constants.backIconName)
            }
            Spacer()
            Button(action: onHeartTap) {
                Image(systemName: isFavorite ? Constants.heartFillImageName : Constants.heartImageName)
            }
        }
        .padding(.vertical)
    }

    let isFavorite: Bool
    let onBackTap: VoidHandler
    let onHeartTap: VoidHandler
}

#Preview {
    NavHeaderView(isFavorite: false, onBackTap: {}, onHeartTap: {})
}
