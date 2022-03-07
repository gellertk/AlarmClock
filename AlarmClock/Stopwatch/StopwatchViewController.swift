//
//  StopWatchViewController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.02.2022.
//

import UIKit
import SnapKit

class StopwatchViewController: UIViewController {
    
    private var stopWatchView: UIView = {
        
       return StopwatchView()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.addSubview(stopWatchView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        stopWatchView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
