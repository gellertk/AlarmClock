//
//  AlarmWeekDaysViewController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 05.05.2022.
//

import UIKit

fileprivate extension WeekDaysViewController {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Int>
    typealias CellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Int>
    typealias Snapshot = NSDiffableDataSourceSnapshot<WeekDaysViewController.Section, Int>
    
    enum Section {
        case main
    }
    
}

class WeekDaysViewController: UIViewController {
    
    weak var delegate: AlarmUpdateDelegate?
    
    private let weekDaysView = WeekDaysView()
    
    private var alarm: Alarm?
    private var dataSource: DataSource!
    
    init(alarm: Alarm) {
        self.alarm = alarm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = weekDaysView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Повтор"
        configureDataSource()
    }
    
    func configureDataSource() {
        let cellRegistration = CellRegistration() {[weak self] (cell, indexPath, item) in
            guard let alarm = self?.alarm else {
                return
            }
            var config = cell.defaultContentConfiguration()
            config.text = item.toWeekDayFullString()
            cell.tintColor = .systemOrange
            if alarm.weekDays[item] ?? false {
                cell.accessories = [.checkmark()]
            }
            cell.contentConfiguration = config
        }
        
        dataSource = DataSource(collectionView: weekDaysView.collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                for: indexPath, item: itemIdentifier)
        })
        
        weekDaysView.collectionView.delegate = self
        
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems((0...6).map { $0 })
        dataSource.apply(snapshot)
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

extension WeekDaysViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? UICollectionViewListCell {
            if cell.accessories.isEmpty {
                cell.accessories = [.checkmark()]
            } else {
                cell.accessories = []
            }
            alarm?.weekDays[indexPath.row]?.toggle()
        }
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}

