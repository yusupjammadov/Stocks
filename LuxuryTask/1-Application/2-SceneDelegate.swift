//
//  SceneDelegate.swift
//  LuxuryTask
//
//  Created by Yusup Jammadov on 29.07.2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let vc = NavigationController(rootViewController: ListVC())
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = vc
        window.makeKeyAndVisible()
        self.window = window
    }
}
