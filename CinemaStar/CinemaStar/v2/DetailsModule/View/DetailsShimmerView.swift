//
//  DetailsShimmerView.swift
//  CinemaStar
//
//  Created by Kate Volkova on 30.05.24.
//

import SwiftUI

/// Заглушка лоадинга деталей
struct DetailsShimmerView: View {
    var body: some View {
        contentView
            .frame(maxHeight: .infinity)
    }

    @State private var isLoadingAnimating = false

    private var contentView: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 16) {
                    HStack(spacing: 16) {
                        makeView(width: 170, height: 200)
                        makeView(height: 110)
                    }
                    makeView(height: 48)
                    makeView(height: 100)
                    makeLabelStubView()
                    makeLabelStubView()
                }
                .padding(.horizontal)

                actorsStubView

                similarMoviesStubView
            }
            .opacity(isLoadingAnimating ? 0.2 : 1)
            .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: isLoadingAnimating)
            .onAppear {
                isLoadingAnimating = true
            }
            .onDisappear {
                isLoadingAnimating = false
            }
        }
        .disabled(true)
    }

    private var similarMoviesStubView: some View {
        Group {
            VStack(alignment: .leading, spacing: 4) {
                makeLabelStubView()
                makeLabelStubView()
            }
            .padding(.horizontal)

            VStack(alignment: .leading, spacing: 8) {
                makeLabelStubView()
                makeView(width: 170, height: 200)
                makeLabelStubView()
            }
            .padding(.horizontal)
        }
    }

    private var actorsStubView: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<7) { _ in
                    makeView(width: 60, height: 97)
                }
            }
            .padding(.horizontal)
        }
        .disabled(true)
    }

    private func makeLabelStubView() -> some View {
        makeView(width: 202, height: 20)
    }

    private func makeView(width: CGFloat? = nil, height: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: 8)
            .frame(width: width, height: height)
            .opacity(0.1)
    }
}

#Preview {
    DetailsShimmerView()
}
