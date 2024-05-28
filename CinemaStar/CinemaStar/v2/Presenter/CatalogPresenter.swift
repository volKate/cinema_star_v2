//
//  CatalogPresenter.swift
//  CinemaStar
//
//  Created by Kate Volkova on 27.05.24.
//

import Combine
import SwiftUI

/// Презентер каталога
final class CatalogPresenter: ObservableObject {

    @Published var catalog: [MoviePreview] = []
    @Published var viewState: ViewState<[MoviePreview]> = .initial

    private let router: CatalogRouter
    @ObservedObject private var interactor: CatalogInteractor
    private var cancellablesSet = Set<AnyCancellable>()

    @Published private var posters: [Image] = []

    init(router: CatalogRouter, interactor: CatalogInteractor) {
        self.interactor = interactor
        self.router = router

        setupBindings()
    }

    func fetchCatalog() {
        viewState = .loading
        interactor.fetchCatalog()
    }

    private func setupBindings() {
        interactor.fetchResult
            .receive(on: RunLoop.main)
            .assign(to: &$catalog)

        $catalog
            .combineLatest($posters)
            .sink { completion in
                // ??
            } receiveValue: { (catalog, posters) in
                guard !posters.isEmpty else {
                    // moviewPreviewsWithPoster = []
                    return
                }
                // moviePreviewsWithPoster = zip arrays
//                viewState = .data(moviePreviewsWithPoster)
            }
            .store(in: &cancellablesSet)
    }
}
