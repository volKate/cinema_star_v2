//
//  NoDataMessageView.swift
//  CinemaStar
//
//  Created by Kate Volkova on 30.05.24.
//

import SwiftUI

/// Универсально сообщение о пустых данных
struct NoDataMessageView: View {
    private enum Constants {
        static let iconName = "exclamationmark.magnifyingglass"
        static let message = "Sorry\nNo Data Found"
    }

    var body: some View {
        MessageView(
            iconName: Constants.iconName,
            message: Constants.message
        )
        .foregroundStyle(.white)
        .frame(maxHeight: .infinity, alignment: .center)
    }
}

#Preview {
    NoDataMessageView()
}
