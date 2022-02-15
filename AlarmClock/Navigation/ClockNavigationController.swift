//
//  ClockNavigationViewController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 08.02.2022.
//

import UIKit

class ClockNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        navigationBar.prefersLargeTitles = true
        navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.isTranslucent = false
        navigationBar.tintColor = Constants.buttonColor
        navigationBar.barStyle = .black
        navigationBar.topItem?.setLeftBarButton(UIBarButtonItem(title: "Править",
                                                                style: .plain,
                                                                target: nil,
                                                                action: #selector(didTapEditButton)), animated: false)
        navigationBar.topItem?.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "plus"),
                                                                 style: .plain,
                                                                 target: nil,
                                                                 action: #selector(WorldClockViewController.didTapAddButton)), animated: false)
    }
    
    //    @objc private func didTapAddButton() {
    //
    //    }
    
    @objc private func didTapEditButton() {
        
    }
    
}
