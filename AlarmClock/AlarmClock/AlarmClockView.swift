//
//  AlarmClockView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.02.2022.
//

import UIKit

class AlarmClockView: UIView {
    
    lazy var alarmsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(AlarmClockTableViewCell.self, forCellReuseIdentifier: AlarmClockTableViewCell.reuseIdentifier)
        tableView.backgroundColor = .black
        tableView.separatorColor = K.Color.tableSeparator
        tableView.separatorInset = .zero
        tableView.layoutMargins = .zero
        tableView.allowsSelection = false
        
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
        alarmsTableView.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    
    func setupConstraints() {
        alarmsTableView.snp.makeConstraints {
            $0.top.bottom.trailing.equalToSuperview()
            $0.leading.equalToSuperview().offset(15)
        }
    }
    
}
