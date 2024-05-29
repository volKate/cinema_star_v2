//
//  DetailsScreenView.swift
//  CinemaStar
//
//  Created by Kate Volkova on 29.05.24.
//

import SwiftUI

///
struct DetailsScreenView: View {
    var body: some View {
        Text("Hello, \(presenter.id)!")
    }

    @StateObject var presenter: DetailsPresenter
}

#Preview {
    AppScreenBuilder.stub.build(view: .details(id: 1))
}
