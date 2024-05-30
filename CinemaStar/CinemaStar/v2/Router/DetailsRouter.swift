//
//  DetailsRouter.swift
//  CinemaStar
//
//  Created by Kate Volkova on 30.05.24.
//

import Foundation

/// Роутер деталей
final class DetailsRouter {
    private var navigation: NavigationService

    init(navigation: NavigationService) {
        self.navigation = navigation
    }

    func goBack() {
        navigation.items.removeLast()
    }
}
