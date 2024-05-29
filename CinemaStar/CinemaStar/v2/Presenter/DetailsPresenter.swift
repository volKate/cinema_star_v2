//
//  DetailsPresenter.swift
//  CinemaStar
//
//  Created by Kate Volkova on 29.05.24.
//

import Foundation

final class DetailsPresenter: ObservableObject {
    @Published var id: Int

    init(id: Int) {
        self.id = id
    }
}
