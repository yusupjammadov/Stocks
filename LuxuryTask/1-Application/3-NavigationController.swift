//
//  NavigationController.swift
//  LuxuryTask
//
//  Created by Yusup Jammadov on 31.07.2025.
//

import UIKit

class NavigationController: UINavigationController {
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        isNavigationBarHidden = true
        interactivePopGestureRecognizer?.delegate = self
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NavigationController: UIGestureRecognizerDelegate {
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
