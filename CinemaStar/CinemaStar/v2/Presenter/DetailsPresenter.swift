//
//  DetailsPresenter.swift
//  CinemaStar
//
//  Created by Kate Volkova on 29.05.24.
//

import Foundation

final class DetailsPresenter: ObservableObject {
    @Published var id: Int
    @Published var isFavorite = false

    private let router: DetailsRouter
    private let interactor: DetailsInteractor

    init(id: Int, router: DetailsRouter, interactor: DetailsInteractor) {
        self.id = id
        self.router = router
        self.interactor = interactor
    }

    func goBack() {
        router.goBack()
    }
}
