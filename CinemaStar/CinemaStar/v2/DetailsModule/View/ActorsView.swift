//
//  ActorsView.swift
//  CinemaStar
//
//  Created by Kate Volkova on 30.05.24.
//

import SwiftUI

/// Инормация об актерах
struct ActorsView: View {
    let actors: [ActorCard]

    var body: some View {
        contentView
            .foregroundStyle(.white)
    }

    private var contentView: some View {
        VStack(alignment: .leading) {
            Text(Local.Details.Title.actors)
                .font(.interBold(ofSize: 14))
                .padding(.horizontal, 16)

            actorsGridView
        }
        .frame(maxWidth: .infinity)
    }

    private var actorsGridView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: gridRows) {
                ForEach(actors, id: \.name) { actor in
                    makeActorView(actor)
                }
            }
            .padding(.horizontal, 16)
        }
    }

    private let gridRows = [
        GridItem(.fixed(60), spacing: 4)
    ]

    private func makeActorView(_ actor: ActorCard) -> some View {
        VStack {
            actor.photo
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 46, height: 73)
            Text(actor.name)
                .font(.inter(ofSize: 8))
                .multilineTextAlignment(.center)
                .lineLimit(2)
        }
        .frame(width: 60, height: 100, alignment: .top)
    }
}
