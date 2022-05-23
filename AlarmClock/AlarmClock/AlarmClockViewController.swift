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
    private var cellsData: [CellData] = []
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
        alarms.forEach {
            cellsData.append(CellData(cellType: ._switch, text: $0.time.toHoursMinutes(), secondaryText: $0.title))
        }
    }
    
    func createCellRegistration() -> CellRegistrationType {
        return CellRegistrationType() { cell, _, item in
            cell.configure(text: item.text)
            cell.accessories = item.isCheckmarked ? [.checkmark()] : []
        }
    }
    
    func setupDataSource() {
        let cellRegistration = createCellRegistration()
        
        dataSource = DataSourceType(collectionView: alarmClockView.collectionView) {
            collectionView, indexPath, item in
            switch item.cellType {
                //cellRegistration
            case .checkmark:
                return collectionView.dequeueConfiguredReusableCell(using: cellRegistration,
                                                                    for: indexPath,
                                                                    item: item)
            case .value:
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
            snapshot.appendSections([section])
            snapshot.appendItems(cell)
        }
//        Section.allCases.forEach {
//            if let cells = cellsData[$0]  {
//                snapshot.appendSections([$0])
//                snapshot.appendItems(cells)
//            }
//        }
        dataSource?.apply(snapshot)
        
        alarmClockView.collectionView.delegate = self
    }
    
    func setupHeader() {
        
        guard let dataSource = dataSource else {
            return
        }
        
        let headerRegistration = UICollectionView.SupplementaryRegistration(elementKind: UICollectionView.elementKindSectionHeader) { (cell: UICollectionViewListCell, elementKind, indexPath) in
            var configuration = cell.defaultContentConfiguration()
            //configuration.text = Section.allCases[indexPath.section].headerTitle
            
            cell.contentConfiguration = configuration
        }
        
        dataSource.supplementaryViewProvider = { (collectionView, _, indexPath) in
            
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
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
