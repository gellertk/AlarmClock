//
//  AlarmMelodyViewController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 09.05.2022.
//

import UIKit

class AlarmMelodyViewController: UIViewController {
    
    weak var delegate: AlarmUpdateDelegate?
    
    private var alarm: Alarm?
    
    private let alarmMelodyView = AlarmMelodyView()
    
    lazy var dataSource = MelodyDataSource(tableView: alarmMelodyView.tableView) { tableView, indexPath, item in
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlarmMelodyTableViewCell.reuseIdentifier) as? AlarmMelodyTableViewCell else {
//            return AlarmMelodyTableViewCell()
//        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DefaultTableViewCell.reuseIdentifier, for: indexPath)
                
        var config = UIListContentConfiguration.valueCell()
        config.text = "\(item)"
        cell.contentConfiguration = config
        
        return cell
    }
    
    init(alarm: Alarm) {
        self.alarm = alarm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = alarmMelodyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Мелодия"
        setupDelegates()
        reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            guard let alarm = alarm else {
                return
            }
            delegate?.update(alarm: alarm)
        }
    }
}

private extension AlarmMelodyViewController {
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<MelodySection, AnyHashable>()
        for section in MelodySection.allCases {
            snapshot.appendSections([section])
            switch section {
            case .vibration(let items):
                snapshot.appendItems(items)
            case .shop( _, let items):
                snapshot.appendItems(items)
            case .song( _, let items):
                snapshot.appendItems(items)
            case .ringtone( _, let items):
                snapshot.appendItems(items)
            case .no(let items):
                snapshot.appendItems(items)
            }
        }
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
    
    func setupDelegates() {
        alarmMelodyView.tableView.delegate = self
    }
    
}

extension AlarmMelodyViewController: UITableViewDelegate {
    
    //    func reloadData() {
    //        var snapshot = NSDiffableDataSourceSnapshot<AlarmSection, Alarm>()
    //        for category in AlarmSection.allCases {
    //            let items = Alarm.getAlarms().filter { $0.section == category }
    //            snapshot.appendSections([category])
    //            snapshot.appendItems(items)
    //        }
    //        DispatchQueue.main.async {
    //            self.dataSource?.apply(snapshot, animatingDifferences: false)
    //        }
    //    }
    
}
