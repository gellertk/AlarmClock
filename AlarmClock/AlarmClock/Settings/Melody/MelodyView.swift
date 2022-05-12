//
//  AlarmMelodyView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 09.05.2022.
//

import UIKit

class MelodyView: UIView {
    
    lazy var tableView: TableView = {
        let cellTypes = [ValueTableViewCell.self, DefaultTableViewCell.self]
        let tableView = TableView(cellTypes: cellTypes)
        tableView.tableHeaderView = .init(frame: .init(x: 0, y: 0, width: 0, height: 20))

        return tableView
    }()
        
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension MelodyView {
    
    func setupView() {
        backgroundColor = K.Color.disabledBackground
        [tableView].forEach {
            addSubview($0)
        }
        setupConstraints()
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}

