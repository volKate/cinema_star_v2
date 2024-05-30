//
//  DetailsPresenter.swift
//  CinemaStar
//
//  Created by Kate Volkova on 29.05.24.
//

import Combine
import Foundation

final class DetailsPresenter: ObservableObject {
    @Published var id: Int
    @Published var isFavorite = false
    @Published var viewState: ViewState<MovieDetailsViewData> = .initial

    private let router: DetailsRouter
    private let interactor: DetailsInteractor
    private var cancellablesSet = Set<AnyCancellable>()

    init(id: Int, router: DetailsRouter, interactor: DetailsInteractor) {
        self.id = id
        self.router = router
        self.interactor = interactor
    }

    func fetchDetails() {
        viewState = .loading
        interactor.fetchDetails(id: id)
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
            } receiveValue: { [unowned self] movieDetails in
                viewState = .data(movieDetails)
            }
            .store(in: &cancellablesSet)
    }

    func goBack() {
        router.goBack()
    }
}
