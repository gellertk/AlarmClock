//
//  AlarmTitleViewController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 09.05.2022.
//

import UIKit

class TitleViewController: UIViewController {
    
    weak var delegate: AlarmUpdateDelegate?
    
    private var alarm: Alarm?

    private lazy var titleView = TitleView(title: alarm?.title ?? "")
    
    init(alarm: Alarm) {
        self.alarm = alarm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = titleView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Название"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            alarm?.title = titleView.getTitle()
            guard let alarm = alarm else {
                return
            }
            delegate?.update(with: alarm)
        }
    }

}

