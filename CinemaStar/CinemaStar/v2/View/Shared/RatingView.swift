//
//  RatingView.swift
//  CinemaStar
//
//  Created by Kate Volkova on 27.05.24.
//

import SwiftUI

/// Форматированный рейтинг
struct RatingView: View {
    let rating: Double

    var body: some View {
        HStack(alignment: .center) {
            Text("⭐️")
                .font(.system(size: 14))
            Text(ratingStr)
        }
    }

    private var ratingStr: String {
        String(format: "%.1f", rating).replacingOccurrences(of: ".", with: ",")
    }

    init(_ rating: Double) {
        self.rating = rating
    }
}

#Preview {
    RatingView(5.6)
}
