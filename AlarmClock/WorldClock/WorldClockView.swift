//
//  WorldClockView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.02.2022.
//

import UIKit

class WorldClockView: UIView {
    
    public lazy var worldClockTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(WorldClockTableViewCell.self, forCellReuseIdentifier: Constants.worldClockCellId)
        tableView.backgroundColor = .black
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = UIColor(white: 1, alpha: 0.35)
        return tableView
    }()

    init() {
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    private func setupView() {
        addSubview(worldClockTableView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            worldClockTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            worldClockTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            worldClockTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            worldClockTableView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
