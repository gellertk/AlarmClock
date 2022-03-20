//
//  WorldClockView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.02.2022.
//

import UIKit
import SnapKit

class WorldClockView: UIView {
    
    public lazy var worldClockTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(WorldClockTableViewCell.self, forCellReuseIdentifier: Constants.worldClockCellId)
        tableView.backgroundColor = .black
        tableView.separatorColor = Constants.tableSeparatorColor
        
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
        worldClockTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
