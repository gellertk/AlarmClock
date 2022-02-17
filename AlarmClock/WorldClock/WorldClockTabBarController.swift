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
        
        let titlesAndImages: [String: UIImage] = [
            "Мировые часы": UIImage(systemName: "globe") ?? UIImage(),
            "Будильник": UIImage(systemName: "alarm.fill") ?? UIImage(),
            "Секундомер": UIImage(systemName: "stopwatch.fill") ?? UIImage(),
            "Таймер": UIImage(systemName: "timer") ?? UIImage()
        ]
        
        var index = 0
        for titleAndImageKey in titlesAndImages.keys {
            items[index].title = titleAndImageKey
            items[index].image = titlesAndImages[titleAndImageKey]
            index += 1
        }
        tabBar.unselectedItemTintColor = .gray
        tabBar.tintColor = .systemOrange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
