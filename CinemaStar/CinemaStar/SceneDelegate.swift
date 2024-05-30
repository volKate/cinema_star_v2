// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import SwiftUI
import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        configureWindow(with: scene)
    }

    private func configureWindow(with scene: UIScene) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white

        let appScreenBuilder = AppScreenBuilder()
        let rootView = appScreenBuilder.createRoot()
        let hostingController = UIHostingController(rootView: rootView)
        window?.rootViewController = hostingController
    }
}
