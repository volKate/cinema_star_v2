//
//  NavigationService.swift
//  CinemaStar
//
//  Created by Kate Volkova on 28.05.24.
//

import SwiftUI

/// Сервис навигации
final class NavigationService: ObservableObject {
    @Published var items: [AppScreen] = []
    @Published var alert: AlertMessage?
}
