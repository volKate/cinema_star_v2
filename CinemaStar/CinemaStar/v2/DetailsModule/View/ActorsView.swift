//
//  ActorsView.swift
//  CinemaStar
//
//  Created by Kate Volkova on 30.05.24.
//

import SwiftUI

/// Инормация об актерах
struct ActorsView: View {
    private enum Constants {
        static let actorsTitle = "Актеры и съемочная группа "
    }

    let actors: [String]

    var body: some View {
        contentView
            .foregroundStyle(.white)
    }

    private var contentView: some View {
        VStack(alignment: .leading) {
            Text(Constants.actorsTitle)
                .font(.system(size: 14, weight: .bold))
                .padding(.horizontal, 16)

            actorsGridView
        }
        .frame(maxWidth: .infinity)
    }

    private var actorsGridView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: gridRows) {
                ForEach(actors, id: \.self) { actor in
                    makeActorView(actor)
                }
            }
            .padding(.horizontal, 16)
        }
    }

    private let gridRows = [
        GridItem(.fixed(60), spacing: 4)
    ]

    private func makeActorView(_ actor: String) -> some View {
        VStack {
            Image(.posterPlaceholder)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 46, height: 73)
            Text(actor)
                .font(.system(size: 8))
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
        .frame(width: 60, height: 100, alignment: .top)
    }
}

#Preview {
    ActorsView(actors: Array(repeating: "Name", count: 10))
}
