//
//  AlarmDataSource.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 02.05.2022.
//

import UIKit

class AlarmDataSource: UITableViewDiffableDataSource<AlarmCategory, Alarm> {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return AlarmCategory.allCases[section].rawValue
    }
    
}

