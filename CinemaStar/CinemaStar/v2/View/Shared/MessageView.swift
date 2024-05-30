//
//  MessageView.swift
//  CinemaStar
//
//  Created by Kate Volkova on 30.05.24.
//

import SwiftUI

/// Системное сообщение
struct MessageView: View {
    let iconName: String
    let message: String
    let actionLabel: String?
    let action: VoidHandler?

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: iconName)
                .font(.largeTitle)
            Text(message)
                .multilineTextAlignment(.center)
            if let action, let actionLabel {
                Button(action: action, label: {
                    Text(actionLabel)
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

    init(iconName: String, message: String, actionLabel: String? = "Retry", action: VoidHandler? = nil) {
        self.iconName = iconName
        self.message = message
        self.actionLabel = actionLabel
        self.action = action
    }
}
