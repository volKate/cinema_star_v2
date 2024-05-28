//
//  MoviesCatalogInteractor.swift
//  CinemaStar
//
//  Created by Kate Volkova on 27.05.24.
//

import Combine
import Foundation

/// Интерактор каталога
final class CatalogInteractor: ObservableObject {

    let fetchResult = PassthroughSubject<[MoviePreview], Never>()

    private let networkService: NetworkServiceProtocol
    private let loadImageService: LoadImageServiceProtocol
    private var cancellablesSet: Set<AnyCancellable> = []

    init(
        networkService: NetworkServiceProtocol,
        loadImageService: LoadImageServiceProtocol
    ) {
        self.networkService = networkService
        self.loadImageService = loadImageService
    }
    
    func fetchCatalog() {
        networkService.loadMovies()
            .receive(on: RunLoop.main)
            .sink { completion in
                if case let .failure(err) = completion {
                    // do smth with error, set it to some error object
                }
            } receiveValue: { [unowned self] moviePreviews in
                fetchResult.send(moviePreviews)

                // for each moviePreview run loadImage
            }
            .store(in: &cancellablesSet)
    }
}
