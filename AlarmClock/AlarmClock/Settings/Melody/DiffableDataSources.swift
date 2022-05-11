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

class MelodyDataSource: UITableViewDiffableDataSource<MelodySection, AnyHashable> {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch MelodySection.allCases[section] {
        case .shop(let title, _):
            return title
        case .song(let title, _):
            return title
        case .ringtone(let title, _):
            return title
        default:
            return nil
        }
    }
    
}

