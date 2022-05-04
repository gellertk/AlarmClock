//
//  MainNavigationController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 03.05.2022.
//

import UIKit

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

private extension MainNavigationController {
    
    func setup() {
        navigationBar.prefersLargeTitles = true
        navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.tintColor = .systemOrange
        navigationBar.barStyle = .black
    }
    
}
