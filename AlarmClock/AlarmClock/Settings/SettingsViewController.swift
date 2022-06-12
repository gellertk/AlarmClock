//
//  AlarmSettingsViewController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 04.05.2022.
//

import UIKit

typealias CellRegistrationType = UICollectionView.CellRegistration<DefaultListCell, CellData>
typealias LeadingCheckmarkCellRegistrationType = UICollectionView.CellRegistration<LeadingCheckmarkListCell, CellData>

protocol AlarmUpdateDelegate: AnyObject {
    func update(with alarm: Alarm)
}

fileprivate extension SettingsViewController {
    
    enum Section: Hashable {
        case main
    }
    
    typealias DataSourceType = UICollectionViewDiffableDataSource<Section, CellData>
    typealias SnapshotType = NSDiffableDataSourceSnapshot<Section, CellData>
    
}

class SettingsViewController: UIViewController {
    
    weak var delegate: AlarmUpdateDelegate?
    
    private var alarm: Alarm?
    
    private var dataSource: DataSourceType?
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
        fillCellsData()
        setupDataSource()
        setupNavigationBar()
    }
    
}

private extension SettingsViewController {
    
    func createValueCellRegistration() -> CellRegistrationType {
        return CellRegistrationType() { cell, _, item in
            cell.configure(text: item.text, secondaryText: item.secondaryText)
            cell.accessories = [.disclosureIndicator()]
        }
    }
    
    func createSwitchCellRegistration() -> CellRegistrationType {
        return CellRegistrationType() { [weak self] (cell, _, item) in
            guard let alarm = self?.alarm else {
                return
            }
            cell.configure(text: item.text)
            cell.accessories = [.disclosureIndicator()]
            let repeatSignalSwitch = UISwitch()
            repeatSignalSwitch.isOn = alarm.isRepeated
            repeatSignalSwitch.addTarget(self, action: #selector(self?.toggleIsRepeated), for: .valueChanged)
            cell.accessories = [.customView(configuration: .init(customView: repeatSignalSwitch,
                                                                 placement: .trailing(displayed: .always)))]
        }
    }
    
    func setupDataSource() {
                
        let valueCellRegistration = createValueCellRegistration()
        let switchCellRegistration = createSwitchCellRegistration()
        
        dataSource = DataSourceType(collectionView: settingsView.collectionView) { collectionView, indexPath, item in
            switch item.cellType {
            case .value:
                return collectionView.dequeueConfiguredReusableCell(using: valueCellRegistration,
                                                                    for: indexPath,
                                                                    item: item)
            case .withSwitch:
                return collectionView.dequeueConfiguredReusableCell(using: switchCellRegistration,
                                                                    for: indexPath,
                                                                    item: item)
            default:
                return nil
            }
        }
        
        setEmptyHeader()
        settingsView.collectionView.delegate = self
        
        var snapshot = SnapshotType()
        snapshot.appendSections([.main])
        snapshot.appendItems(cellsData)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    func setEmptyHeader() {
        settingsView.collectionView.register(EmptyHeaderView.self,
                                                  forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                                  withReuseIdentifier: EmptyHeaderView.reuseIdentifier)
        
        dataSource?.supplementaryViewProvider = { (collectionView, kind, indexPath) in
            
            return collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                                                   withReuseIdentifier: EmptyHeaderView.reuseIdentifier,
                                                                   for: indexPath) as? EmptyHeaderView
        }
    }
    
    func setupNavigationBar() {
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
                     secondaryText: alarm.weekDays.toWeekDaysFormat()) { [weak self] in self?.toWeekDaysVC()},
            CellData(cellType: .value,
                     text: "Название",
                     secondaryText: alarm.title) { [weak self] in self?.toTitleVC() },
            CellData(cellType: .value,
                     text: "Мелодия",
                     secondaryText: alarm.melody?.title ?? "Нет") { [weak self] in self?.toMelodyVC() },
            CellData(cellType: .withSwitch,
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
    
    func update(with alarm: Alarm) {
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
        guard let alarm = alarm else {
            return
        }
        delegate?.update(with: alarm)
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
        let titleVC = TitleViewController(alarm: alarm)
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
