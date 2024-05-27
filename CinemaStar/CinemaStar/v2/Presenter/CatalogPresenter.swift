//
//  CatalogPresenter.swift
//  CinemaStar
//
//  Created by Kate Volkova on 27.05.24.
//

import Foundation
import Combine

final class CatalogPresenter: ObservableObject {

    @Published var catalog: [MoviePreview] = []

    private let interactor: CatalogInteractor
    private var cancellables = Set<AnyCancellable>()

    init(interactor: CatalogInteractor) {
        self.interactor = interactor
    }
}
