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
                    case let .details(id):
                        appScreenBuilder.build(view: .details(id: id))
                    default:
                        fatalError()
                    }
                }
                .alert(
                    navigationService.alert?.title ?? "",
                    isPresented: Binding(
                        get: {
                            navigationService.alert != nil
                        }, set: { isVisible in
                            if !isVisible {
                                navigationService.alert = nil
                            }
                        }
                    )
                ) {
                    if let alert = navigationService.alert {
                        Button(alert.dismissButtonText) {}
                    }
                } message: {
                    if let description = navigationService.alert?.description {
                        Text(description)
                    }
                }
        }
    }
}
