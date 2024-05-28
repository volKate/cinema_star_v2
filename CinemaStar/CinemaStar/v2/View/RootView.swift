//
//  RootView.swift
//  CinemaStar
//
//  Created by Kate Volkova on 28.05.24.
//

import SwiftUI

/// Рутовый вью, обернутый в навигацию
struct RootView: View {
    @ObservedObject var navigationService: NavigationService
    var appScreenBuilder: AppScreenBuilder

    var body: some View {
        NavigationStack(path: $navigationService.items) {
            appScreenBuilder.build(view: .catalog)
                .navigationDestination(for: AppScreen.self) { path in
                    switch path {
//                        What is supposed to happen here and how it works with routers ???
//                        case .details:
//                            appScreenBuilder.build(view: .details)
                    default:
                        fatalError()
                    }
                }
        }
    }
}
