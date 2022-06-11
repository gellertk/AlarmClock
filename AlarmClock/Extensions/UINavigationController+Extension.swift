//
//  UINavigationController+Extension.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 06.05.2022.
//

import UIKit

extension UINavigationController {
    
    open override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    convenience init(rootViewController: UIViewController, prefersLargeTitle: Bool = false) {
        self.init(rootViewController: rootViewController)
        navigationBar.prefersLargeTitles = prefersLargeTitle
        if prefersLargeTitle {
            let backButton = UIBarButtonItem()
            backButton.title = "Назад"
            navigationBar.topItem?.backBarButtonItem = backButton
        }
        
        navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.tintColor = .systemOrange
        overrideUserInterfaceStyle = .dark
    }
    
}
