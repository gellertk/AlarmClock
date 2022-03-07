//
//  TabBarController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 08.02.2022.
//

import UIKit

class WorldClockTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    private func setup() {
        
        setViewControllers([
            UINavigationController(rootViewController: WorldClockViewController()),
            UINavigationController(rootViewController: AlarmClockViewController()),
            StopwatchViewController(),
            TimerViewController()
        ], animated: true)
        
        if let items = tabBar.items {
            
            let titlesAndImages: KeyValuePairs = [
                "Мировые часы": UIImage(systemName: "globe") ?? UIImage(),
                "Будильник": UIImage(systemName: "alarm.fill") ?? UIImage(),
                "Секундомер": UIImage(systemName: "stopwatch.fill") ?? UIImage(),
                "Таймер": UIImage(systemName: "timer") ?? UIImage()
            ]
            
            for index in titlesAndImages.indices {
                items[index].title = titlesAndImages[index].key
                items[index].image = titlesAndImages[index].value
            }
            
            tabBar.unselectedItemTintColor = .gray
            tabBar.tintColor = .systemOrange
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
