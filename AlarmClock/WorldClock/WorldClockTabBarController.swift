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
            StopWatchViewController(),
            TimerViewController()
        ], animated: true)
        
        guard let items = tabBar.items else {
            return
        }
        
        let titles = [
            "Мировые часы",
            "Будильник",
            "Секундомер",
            "Таймер"
        ]
        
        let images = [
            UIImage(systemName: "globe") ?? UIImage(),
            UIImage(systemName: "alarm.fill") ?? UIImage(),
            UIImage(systemName: "stopwatch.fill") ?? UIImage(),
            UIImage(systemName: "timer") ?? UIImage()
        ]
        
        for index in titles.indices {
            items[index].title = titles[index]
            items[index].image = images[index]
        }
        tabBar.unselectedItemTintColor = .gray
        tabBar.tintColor = .systemOrange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   

}
