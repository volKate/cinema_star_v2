//
//  AppViewBuilder.swift
//  CinemaStar
//
//  Created by Kate Volkova on 28.05.24.
//

import SwiftUI

/// Перечисление экранов
enum AppScreen: Hashable {
    case catalog
    case details
}

/// Билдер экранов
final class AppScreenBuilder {
    static let stub = AppScreenBuilder()
    private let navigationService = NavigationService()
    private let networkService = NetworkService()
    private let loadImageService = LoadImageService()

    func createRoot() -> some View {
        RootView(navigationService: navigationService, appScreenBuilder: self)
    }

    @ViewBuilder
    func build(view: AppScreen) -> some View {
        switch view {
        case .catalog:
            buildCatalog()
        case .details:
            buildCatalog()
        }
    }

    private func buildCatalog() -> some View {
      let router = CatalogRouter(navigation: navigationService)
      let interactor = CatalogInteractor(networkService: networkService, loadImageService: loadImageService)
      let presenter = CatalogPresenter(router: router, interactor: interactor)
      let view = CatalogScreenView(presenter: presenter)
      return view
    }
}
