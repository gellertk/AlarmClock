//
//  TabBarController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 08.02.2022.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    private func setup() {
        
        setViewControllers([
            UINavigationController(rootViewController: WorldClockViewController(), withLargeTitle: true),
            UINavigationController(rootViewController: AlarmClockViewController(), withLargeTitle: true),
            StopwatchViewController(),
            TimerViewController()
        ], animated: true)
        
        if let items = tabBar.items {
            
            let titlesAndImages: KeyValuePairs = [
                "Мировые часы": K.SystemImage.worldClock,
                "Будильник": K.SystemImage.alarmClock,
                "Секундомер": K.SystemImage.stopwatch,
                "Таймер": K.SystemImage.timer
            ]
            
            for index in titlesAndImages.indices {
                items[index].title = titlesAndImages[index].key
                items[index].image = titlesAndImages[index].value
            }
            
            tabBar.unselectedItemTintColor = .gray
            tabBar.tintColor = .systemOrange
            tabBar.barTintColor = .black
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
