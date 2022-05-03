//
//  AlarmClockView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.02.2022.
//

import UIKit

class AlarmClockView: UIView {
    
    private(set) lazy var alarmsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(AlarmClockTableViewCell.self, forCellReuseIdentifier: AlarmClockTableViewCell.reuseId)
        tableView.backgroundColor = .black
        
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AlarmClockView {
    
    func setupView() {
        backgroundColor = .black
        addSubview(alarmsTableView)
        setupConstraints()
    }
    
    func setupConstraints() {
        alarmsTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
