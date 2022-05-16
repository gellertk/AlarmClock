//
//  AlarmSettingsViewController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 04.05.2022.
//

import UIKit

protocol AlarmUpdateDelegate: AnyObject {
    func update(alarm: Alarm)
}

fileprivate extension SettingsViewController {
    
    typealias CellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, CellData>
    typealias DataSource = UICollectionViewDiffableDataSource<SettingsViewController.Section, CellData>
    typealias Snapshot = NSDiffableDataSourceSnapshot<SettingsViewController.Section, CellData>
    
    enum Section: Hashable {
        case main
    }
    
}

class SettingsViewController: UIViewController {
    
    var alarm: Alarm?
    
    private var dataSource: DataSource?
    private var updatedCellIndex: Int?
    private var cellsData: [CellData] = []
    
    private let settingsView = SettingsView()
        
    init(alarm: Alarm) {
        self.alarm = alarm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Добавление"
        setupNavigationBarItems()
        setupDataSource()
    }
    
}

private extension SettingsViewController {
    
    func createValueCellRegistration() -> CellRegistration {
        return CellRegistration() {[weak self] (cell, indexPath, item) in
            var config = UIListContentConfiguration.valueCell()
            config.text = item.text
            config.secondaryText = self?.alarm?[indexPath.row]
            cell.contentConfiguration = config
            cell.accessories = [.disclosureIndicator()]
        }
    }
    
    func createSwitchCellRegistration() -> CellRegistration {
        return CellRegistration() {[weak self] (cell, _, item) in
            guard let alarm = self?.alarm else {
                return
            }
            var config = cell.defaultContentConfiguration()
            config.text = item.text
            let repeatSignalSwitch = UISwitch()
            repeatSignalSwitch.isOn = alarm.isRepeated
            repeatSignalSwitch.addTarget(self, action: #selector(self?.toggleIsRepeated), for: .valueChanged)
            cell.accessories = [.customView(configuration: .init(customView: repeatSignalSwitch,
                                                                 placement: .trailing(displayed: .always)))]
            cell.contentConfiguration = config
        }
    }
    
    func setupDataSource() {
        
        fillCellsData()
        
        let valueCellRegistration = createValueCellRegistration()
        let switchCellRegistration = createSwitchCellRegistration()
        
        dataSource = DataSource(collectionView: settingsView.collectionView) { collectionView, indexPath, item in
            switch item.cellType {
            case .value:
                return collectionView.dequeueConfiguredReusableCell(using: valueCellRegistration, for: indexPath, item: item)
            case ._switch:
                return collectionView.dequeueConfiguredReusableCell(using: switchCellRegistration, for: indexPath, item: item)
            default:
                return nil
            }
        }
        
        setEmptyHeader()
        settingsView.collectionView.delegate = self
        
        guard let dataSource = dataSource else {
            return
        }
        
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(cellsData)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func setEmptyHeader() {
        settingsView.collectionView.register(EmptyHeaderView.self,
                                                  forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                                  withReuseIdentifier: EmptyHeaderView.reuseIdentifier)
        
        dataSource?.supplementaryViewProvider = { (collectionView, kind, indexPath)  in
            return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                   withReuseIdentifier: EmptyHeaderView.reuseIdentifier,
                                                                   for: indexPath) as? EmptyHeaderView
        }
    }
    
    func setupNavigationBarItems() {
        navigationItem.setLeftBarButton(UIBarButtonItem(title: "Отменить",
                                                        style: .plain,
                                                        target: self,
                                                        action: #selector(didTapCancelButton)), animated: false)
        navigationItem.setRightBarButton(UIBarButtonItem(title: "Сохранить",
                                                         style: .done,
                                                         target: self,
                                                         action: #selector(didTapSaveButton)), animated: false)
        
    }
    
    func fillCellsData() {
        guard let alarm = alarm else {
            return
        }
        
        cellsData = [
            CellData(cellType: .value,
                     text: "Повтор",
                     secondaryText: alarm.formatedWeekDays()) { [weak self] in self?.toWeekDaysVC()},
            CellData(cellType: .value,
                     text: "Название",
                     secondaryText: alarm.title) { [weak self] in self?.toTitleVC() },
            CellData(cellType: .value,
                     text: "Мелодия",
                     secondaryText: alarm.melody?.title ?? "Нет") { [weak self] in self?.toMelodyVC() },
            CellData(cellType: ._switch,
                     text: "Повторение сигнала")
        ]
        
    }
    
}

extension SettingsViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return indexPath.row != cellsData.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updatedCellIndex = indexPath.row
        let cellData = cellsData[indexPath.row]
        cellData.handler?()
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}

extension SettingsViewController: AlarmUpdateDelegate {
    
    func update(alarm: Alarm) {
        guard let updatedCellIndex = updatedCellIndex,
        let dataSource = dataSource else {
            return
        }
        self.alarm = alarm
        cellsData[updatedCellIndex].secondaryText = alarm[updatedCellIndex]
        var newSnapshot = dataSource.snapshot()
        newSnapshot.reconfigureItems([cellsData[updatedCellIndex]])
        dataSource.apply(newSnapshot, animatingDifferences: false)
    }
    
}

private extension SettingsViewController {
    
    @objc func didTapCancelButton() {
        dismiss(animated: true)
    }
    
    @objc func didTapSaveButton() {
        dismiss(animated: true)
    }
    
    @objc func toggleIsRepeated() {
        alarm?.isRepeated.toggle()
    }
    
    func toWeekDaysVC() {
        guard let alarm = alarm else {
            return
        }
        
        let weekDaysVC = WeekDaysViewController(alarm: alarm)
        weekDaysVC.delegate = self
        navigationController?.pushViewController(weekDaysVC,
                                                 animated: true)
    }
    
    func toTitleVC() {
        guard let alarm = alarm else {
            return
        }
        
        let titleVC = AlarmTitleViewController(alarm: alarm)
        titleVC.delegate = self
        navigationController?.pushViewController(titleVC,
                                                 animated: true)
    }
    
    func toMelodyVC() {
        guard let alarm = alarm else {
            return
        }
        
        let melodyVC = MelodyViewController(alarm: alarm)
        melodyVC.delegate = self
        navigationController?.pushViewController(melodyVC,
                                                 animated: true)
    }
    
}
