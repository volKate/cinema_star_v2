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
            Image(systemName: isFavorite ? Constants.heartFillImageName : Constants.heartImageName)
        }
        .padding(.vertical)
    }

    @Binding var isFavorite: Bool
    let onBackTap: VoidHandler
}

#Preview {
    NavHeaderView(isFavorite: .constant(false), onBackTap: {})
}
