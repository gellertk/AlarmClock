//
//  UINavigationController+Extension.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 06.05.2022.
//

import UIKit

extension UINavigationController {
    
    convenience init(rootViewController: UIViewController, withLargeTitle: Bool) {
        self.init(rootViewController: rootViewController)
        setupDefault(withLargeTitle)
    }
    
    func setupDefault(_ withLargeTitle: Bool) {
        let backButton = UIBarButtonItem()
        backButton.title = "Назад"
        navigationBar.topItem?.backBarButtonItem = backButton
        
        navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.tintColor = .systemOrange
        navigationBar.barStyle = .black
        
        navigationBar.prefersLargeTitles = withLargeTitle
    }
    
}
