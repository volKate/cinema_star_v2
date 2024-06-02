// BackgroundView.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI

/// Стандартный фоновый вью с градиентом
struct BackgroundView<Content: View>: View {
    let content: () -> Content

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.bgBrown, .bgGreen],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            content()
        }
    }
}

#Preview {
    BackgroundView {
        Text("Hello")
    }
}
