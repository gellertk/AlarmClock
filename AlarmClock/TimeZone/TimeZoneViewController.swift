//
//  TimeZoneViewController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 16.02.2022.
//

import UIKit

class TimeZoneViewController: UIViewController {
    
    private lazy var timeZoneView: UIView = {
        let view = TimeZoneView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //title = "Выбрать город"
        setupView()
    }
    
    private func setupView() {
        view.addSubview(timeZoneView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            timeZoneView.topAnchor.constraint(equalTo: view.topAnchor),
            timeZoneView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            timeZoneView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            timeZoneView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
}
