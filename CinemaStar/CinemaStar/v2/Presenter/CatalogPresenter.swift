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

    @Published var viewState: ViewState<[MovieCard]> = .initial
    @Published private(set) var loadingStubCards: [MovieCard] = {
        var cards: [MovieCard] = []
        for _ in 0...7 {
            cards.append(MovieCard.createMock())
        }
        return cards
    }()

    private let router: CatalogRouter
    private let interactor: CatalogInteractor
    private var cancellablesSet = Set<AnyCancellable>()

    init(router: CatalogRouter, interactor: CatalogInteractor) {
        self.interactor = interactor
        self.router = router
    }

    func fetchCatalog() {
        viewState = .loading
        interactor.fetchCatalog()
            .receive(on: RunLoop.main)
            .sink { [unowned self] completion in
                switch completion {
                case .finished:
                    cancellablesSet.removeAll()
                case let .failure(error):
                    switch error {
                    case .noData:
                        viewState = .noData
                    default:
                        viewState = .error
                    }
                }
            } receiveValue: { [unowned self] movieCards in
                viewState = .data(movieCards)
            }
            .store(in: &cancellablesSet)
    }

    func openDetails(id: Int) {
        router.navigateToDetails(id: id)
    }
}
