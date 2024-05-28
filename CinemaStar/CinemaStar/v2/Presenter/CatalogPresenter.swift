//
//  CatalogPresenter.swift
//  CinemaStar
//
//  Created by Kate Volkova on 27.05.24.
//

import Combine
import Foundation

/// Презентер каталога
final class CatalogPresenter: ObservableObject {

    @Published var catalog: [MoviePreview] = []

    private let router: CatalogRouter
    private let interactor: CatalogInteractor
    private var cancellablesSet = Set<AnyCancellable>()

    init(router: CatalogRouter, interactor: CatalogInteractor) {
        self.interactor = interactor
        self.router = router
    }
}
