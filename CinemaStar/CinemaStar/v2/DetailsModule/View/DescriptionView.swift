//
//  DescriptionView.swift
//  CinemaStar
//
//  Created by Kate Volkova on 30.05.24.
//

import SwiftUI

/// Описание и информация о релизе
struct DescriptionView: View {
    private enum Constants {
        static let arrowDownIconName = "chevron.down"
        static let arrowUpIconName = "chevron.up"
    }

    let description: String
    let releaseInfo: String

    var body: some View {
        contentView
    }

    @State private var isDescriptionExpanded = false

    private var contentView: some View {
        VStack(alignment: .leading, spacing: 10) {
            descriptionView
            releaseView
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var descriptionView: some View {
        HStack(alignment: .lastTextBaseline) {
            Text(description)
                .lineLimit(isDescriptionExpanded ? nil : 4)
                .font(.inter(ofSize: 14))

            expandButtonView
        }
    }

    private var expandButtonView: some View {
        Button {
            withAnimation {
                isDescriptionExpanded.toggle()
            }
        } label: {
            Image(
                systemName: isDescriptionExpanded ?
                    Constants.arrowUpIconName :
                    Constants.arrowDownIconName
            )
            .font(.inter(ofSize: 14))
        }
    }

    private var releaseView: some View {
        Text(releaseInfo)
            .font(.inter(ofSize: 14))
            .foregroundStyle(.black.opacity(0.41))
    }
}

#Preview {
    DescriptionView(description: "1", releaseInfo: "2")
}
