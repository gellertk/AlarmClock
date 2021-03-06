//
//  AlarmClockViewController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.02.2022.
//

import UIKit

class AlarmClockViewController: UIViewController {
    
    typealias CustomCellRegistrationType = UICollectionView.CellRegistration<AlarmListCell, Alarm>
    typealias DataSourceType = UICollectionViewDiffableDataSource<Alarm.Section, Alarm>
    typealias SnapshotType = NSDiffableDataSourceSnapshot<Alarm.Section, Alarm>
    
    private let alarmClockView = AlarmClockView()
    private let firstItemIndexPath = IndexPath(row: 0, section: 0)
    
    private var dataSource: DataSourceType?
    private var alarms = Alarm.getAlarms()
    
    override func loadView() {
        view = alarmClockView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Будильник"
        setupDataSource()
        setupNavigationBar()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        alarmClockView.collectionView.isEditing = editing
    }
    
}

private extension AlarmClockViewController {
    
    func createCellRegistration() -> CustomCellRegistrationType {
        return CustomCellRegistrationType() { cell, indexPath, item in

            cell.configure(with: item)
        }
    }
    
    func setupDataSource() {
        let cellRegistration = createCellRegistration()
        
        dataSource = DataSourceType(collectionView: alarmClockView.collectionView) {
            collectionView, indexPath, item in
            
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                for: indexPath,
                                                                item: item)
        }
        
        setupSectionHeaders()
        applySnapshot()
        setupDelegates()
    }
    
    func setupSectionHeaders() {
        
        let headerRegistration = UICollectionView.SupplementaryRegistration
        <AlarmSectionHeaderReusableView>(elementKind: UICollectionView.elementKindSectionHeader) {
            supplementaryView, string, indexPath in
            let sectionTitle = Alarm.Section.allCases[indexPath.section].rawValue
            if indexPath.section == 0 {
                supplementaryView.configureLabel(with: sectionTitle, and: .bed)
            } else {
                supplementaryView.configureLabel(with: sectionTitle)
            }
        }
        
        dataSource?.supplementaryViewProvider = { (collectionView, _, indexPath) in
            
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration,
                                                                         for: indexPath)
        }
        
    }
    
    func applySnapshot() {
        var snapshot = SnapshotType()
        for section in Alarm.Section.allCases {
            snapshot.appendSections([section])
            snapshot.appendItems(alarms.filter { $0.section == section })
        }
        
        dataSource?.apply(snapshot)
    }
    
    func delete(at indexPath: IndexPath) {
        guard let dataSource = dataSource else {
            return
        }
        var snapshot = dataSource.snapshot()
        if let identifier = dataSource.itemIdentifier(for: indexPath) {
            snapshot.deleteItems([identifier])
        }
        dataSource.apply(snapshot)
    }
    
    func setupDelegates() {
        alarmClockView.collectionView.delegate = self
        alarmClockView.delegate = self
    }
    
    func setupNavigationBar() {
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.leftBarButtonItem?.primaryAction = UIAction(title: "Править") { [unowned self] _ in
            setEditing(!isEditing, animated: true)
            navigationItem.leftBarButtonItem?.title = isEditing ? "Готово" : "Править"
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .add)
        navigationItem.rightBarButtonItem?.primaryAction = UIAction() { [unowned self] _ in
            let settingsVC = SettingsViewController(alarm: Alarm.createDefaultAlarm())
            settingsVC.delegate = self
            present(UINavigationController(rootViewController: settingsVC,
                                           prefersLargeTitle: false),
                    animated: true)
        }
        
    }
    
}

extension AlarmClockViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        return indexPath != firstItemIndexPath
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        let settingsVC = SettingsViewController(alarm: alarms[indexPath.row + 1])
        present(UINavigationController(rootViewController: settingsVC,
                                       prefersLargeTitle: false),
                animated: true)
        
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}

extension AlarmClockViewController: AlarmClockViewDelegate {
    
    func deleteAlarm(at indexPath: IndexPath) {
        delete(at: indexPath)
    }
    
}

extension AlarmClockViewController: AlarmUpdateDelegate {
    
    func update(with alarm: Alarm) {
        alarms.append(alarm)
        guard let dataSource = dataSource else {
            return
        }
        var snapshot = dataSource.snapshot()
        snapshot.appendItems([alarm], toSection: .other)
        dataSource.apply(snapshot)
    }
    
}
