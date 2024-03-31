//
//  SceneDelegate.swift
//  NASA-APIs
//
//  Created by Eduard on 31.03.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private var mainCoordinator: MainCoordinator?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        mainCoordinator = .init(with: window) // start flow with UIWindow
        mainCoordinator?.start()
    }
}

