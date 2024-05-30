//
//  AppViewBuilder.swift
//  CinemaStar
//
//  Created by Kate Volkova on 28.05.24.
//

import SwiftUI

/// Перечисление экранов
enum AppScreen: Hashable {
    /// Экран каталога фильмов
    case catalog
    /// Экран деталей фильма
    case details(id: Int)
}

/// Билдер экранов
final class AppScreenBuilder {
    static let stub = AppScreenBuilder()
    private let navigationService = NavigationService()
    private let networkService = NetworkService()
    private let loadImageService = LoadImageProxy(service: LoadImageService())

    func createRoot() -> some View {
        RootView(navigationService: navigationService, appScreenBuilder: self)
    }

    @ViewBuilder
    func build(view: AppScreen) -> some View {
        switch view {
        case .catalog:
            buildCatalog()
        case .details(let id):
            buildDetails(id: id)
        }
    }

    private func buildCatalog() -> some View {
        let router = CatalogRouter(navigation: navigationService)
        let interactor = CatalogInteractor(networkService: networkService, loadImageService: loadImageService)
        let presenter = CatalogPresenter(router: router, interactor: interactor)
        let view = CatalogScreenView(presenter: presenter)
        return view
    }

    private func buildDetails(id: Int) -> some View {
        let router = DetailsRouter(navigation: navigationService)
        let interactor = DetailsInteractor(networkService: networkService, loadImageService: loadImageService)
        let presenter = DetailsPresenter(id: id, router: router, interactor: interactor)
        let view = DetailsScreenView(presenter: presenter)
        return view
    }
}
