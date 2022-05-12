//
//  AlarmDataSource.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 02.05.2022.
//

import UIKit

class AlarmDataSource: UITableViewDiffableDataSource<AlarmSection, Alarm> {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return AlarmSection.allCases[section].rawValue
    }
    
}

class MelodyDataSource: UITableViewDiffableDataSource<MelodySection, CellType> {
    
    var sections: [MelodySection] = []
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sections[section].title
    }
    
}

