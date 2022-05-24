//
//  AlarmClockViewController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.02.2022.
//

import UIKit

class AlarmClockViewController: UIViewController {
    
    typealias DataSourceType = UICollectionViewDiffableDataSource<Alarm.Section, CellData>
    typealias SnapshotType = NSDiffableDataSourceSnapshot<Alarm.Section, CellData>
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    private let alarmClockView = AlarmClockView()
    
    private var dataSource: DataSourceType?
    private var updatedCellIndex: Int?
    private var cellsData: [Alarm.Section: [CellData]] = [:]
    private var alarms = Alarm.getAlarms()
    
    override func loadView() {
        view = alarmClockView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Будильник"
        fillCellsData()
        setupDataSource()
        setupNavigationBarItems()
    }
    
    func fillCellsData() {
        cellsData[.main] = []
        cellsData[.other] = []
        alarms.forEach { alarm in
            cellsData[alarm.section]?.append(CellData(cellType: .withSwitch,
                                                      text: alarm.time.toHoursMinutes(),
                                                      secondaryText: alarm.title))
        }
    }
    
    func createCellRegistration() -> CellRegistrationType {
        return CellRegistrationType() { cell, _, item in
            //cell.configure(text: item.text)
            var contentConfig = UIListContentConfiguration.subtitleCell()
            contentConfig.text = item.text
            contentConfig.secondaryText = item.secondaryText
            contentConfig.textProperties.font = UIFont.systemFont(
                ofSize: 50,
                weight: .light)
            cell.contentConfiguration = contentConfig
            cell.backgroundView = UIView()
            
            cell.accessories = item.isCheckmarked ? [.checkmark()] : []
        }
    }
    
    func setupDataSource() {
        let cellRegistration = createCellRegistration()
        
        dataSource = DataSourceType(collectionView: alarmClockView.collectionView) {
            collectionView, indexPath, item in
            switch item.cellType {
            case .withSwitch:
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath,
                                                                    item: item)
            default:
                return nil
            }
        }
        
        setupHeader()
        
        var snapshot = SnapshotType()
        for section in Alarm.Section.allCases {
            if let items = cellsData[section] {
                snapshot.appendSections([section])
                snapshot.appendItems(items)
            }
        }
        
        dataSource?.apply(snapshot)
        alarmClockView.collectionView.delegate = self
    }
    
    func setupHeader() {
        
        let headerRegistration = UICollectionView.SupplementaryRegistration
        <AlarmSectionHeaderReusableView>(elementKind: UICollectionView.elementKindSectionHeader) {
            supplementaryView, string, indexPath in
            supplementaryView.titleLabel.text = Alarm.Section.allCases[indexPath.section].rawValue
        }

        dataSource?.supplementaryViewProvider = { (collectionView, _, indexPath) in

            let header = collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration,
                                                                               for: indexPath)

            return header
        }
        
    }
    
}

private extension AlarmClockViewController {
    
    func setupNavigationBarItems() {
        navigationItem.setLeftBarButton(UIBarButtonItem(title: "Править",
                                                        style: .plain,
                                                        target: self,
                                                        action: #selector(didTapEditButton)), animated: false)
        navigationItem.setRightBarButton(UIBarButtonItem(image: K.SystemImage.plus,
                                                         style: .plain,
                                                         target: self,
                                                         action: #selector(didTapAddButton)), animated: false)
    }
    
    @objc private func didTapEditButton() {
        UIView.animate(withDuration: 0.3) {
            self.alarmClockView.collectionView.isEditing.toggle()
            //            self.alarmClockView.alarmsTableView.layoutMargins = UIEdgeInsets(top: 0,
            //                                                                        left: 20,
            //                                                                        bottom: 0,
            //                                                                        right: 0)
        }
        
        //alarmClockView.alarmsTableView.allowsSelection.toggle()
    }
    
    @objc func didTapAddButton() {
        present(UINavigationController(rootViewController: SettingsViewController(alarm: Alarm.createCommonAlarm()),
                                       withLargeTitle: false), animated: true)
    }
    
    func reloadTableViewData() {
        //        var snapshot = SnapshotType()
        //        for category in Section.allCases {
        //            let items = Alarm.getAlarms().filter { $0.section == category }
        //            snapshot.appendSections([category])
        //            snapshot.appendItems(items)
        //        }
        //        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
}

extension AlarmClockViewController: UICollectionViewDelegate {
    
    
    
}
