//
//  ErrorMessageView.swift
//  CinemaStar
//
//  Created by Kate Volkova on 30.05.24.
//

import SwiftUI

/// Универсальное сообщение об ошибке
struct ErrorMessageView: View {
    private enum Constants {
        static let iconName = "exclamationmark.triangle"
        static let message = "Sorry\nAn error occured"
    }

    var body: some View {
        MessageView(
            iconName: Constants.iconName,
            message: Constants.message
        )
        .foregroundStyle(.black)
        .frame(maxHeight: .infinity, alignment: .center)
    }
}

#Preview {
    NoDataMessageView()
}
