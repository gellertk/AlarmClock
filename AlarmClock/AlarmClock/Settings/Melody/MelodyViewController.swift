//
//  AlarmMelodyViewController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 09.05.2022.
//

import UIKit

fileprivate extension MelodyViewController {
    
    typealias CellRegistrationType = UICollectionView.CellRegistration<UICollectionViewListCell, CellData>
    typealias SnapshotType = NSDiffableDataSourceSnapshot<SectionType, CellData>
    
}

class MelodyViewController: UIViewController {
    
    //static let headerElementKind = "header-element-kind"
    
    enum SectionType: String, CaseIterable {
        case vibration
        case shop = "МАГАЗИН"
        case songs = "ПЕСНИ"
        case ringtones = "РИНГТОНЫ"
        case no
    }
    
    weak var delegate: AlarmUpdateDelegate?
    
    private var alarm: Alarm?
    private var cellsData: [SectionType: [CellData]] = [:]
    private var dataSource: MelodyDataSource!
    
    private let melodyView = MelodyView()
    
    init(alarm: Alarm) {
        self.alarm = alarm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = melodyView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Мелодия"
        fillCells()
        setupDataSource()
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

private extension MelodyViewController {
    
    private func checkmarkConfiguration() -> UICellAccessory.CustomViewConfiguration {
        let symbolName = "checkmark"
        let symbolConfiguration = UIImage.SymbolConfiguration(textStyle: .title3)
        let image = UIImage(systemName: symbolName, withConfiguration: symbolConfiguration)
        let button = UIButton()
        button.setImage(image, for: .normal)
        
        return UICellAccessory.CustomViewConfiguration(customView: button, placement: .leading(displayed: .always))
    }
    
    func createValueCellRegistration() -> CellRegistrationType {
        return CellRegistrationType() { cell, _, item in
            var config = UIListContentConfiguration.valueCell()
            config.text = item.text
            config.secondaryText = item.secondaryText
            config.textProperties.numberOfLines = 1
            cell.contentConfiguration = config
            cell.accessories = [.disclosureIndicator()]
        }
    }
    
    func createSystemCellRegistration() -> CellRegistrationType {
        return CellRegistrationType() { cell, _, item in
            var config = UIListContentConfiguration.cell()
            config.text = item.text
            config.textProperties.numberOfLines = 1
            config.textProperties.color = .systemOrange
            cell.contentConfiguration = config
        }
    }
    
    func createLeftCheckmarkCellRegistration() -> CellRegistrationType {
        return CellRegistrationType() {[weak self] cell, _, item in
            guard let self = self else {
                return
            }
            var config = UIListContentConfiguration.cell()
            config.text = item.text
            config.textProperties.numberOfLines = 1
            cell.contentConfiguration = config
            var checkmark = self.checkmarkConfiguration()
            checkmark.tintColor = .systemOrange
            cell.accessories = [.customView(configuration: checkmark)]
        }
    }
    
    func createLeftCheckmarkWitchDisclouserCellRegistration() -> CellRegistrationType {
        return CellRegistrationType() {[weak self] cell, _, item in
            guard let self = self else {
                return
            }
            var config = UIListContentConfiguration.cell()
            config.text = item.text
            config.textProperties.numberOfLines = 1
            cell.contentConfiguration = config
            var checkmark = self.checkmarkConfiguration()
            checkmark.tintColor = .systemOrange
            cell.accessories = [.customView(configuration: checkmark), .disclosureIndicator()]
        }
    }
    
    func setupDataSource() {
        let valueCellRegistration = createValueCellRegistration()
        let systemCellRegistration = createSystemCellRegistration()
        let leftCheckmarkedCellRegistration = createLeftCheckmarkCellRegistration()
        //let leftCheckmarkWithDisclouser = createLeftCheckmarkWitchDisclouserCellRegistration()
        
        dataSource = MelodyDataSource(collectionView: melodyView.collectionView) { collectionView, indexPath, itemIdentifier in
            switch SectionType.allCases[indexPath.section] {
            case .vibration:
                return collectionView.dequeueConfiguredReusableCell(using: valueCellRegistration, for: indexPath, item: itemIdentifier)
            case .shop:
                return collectionView.dequeueConfiguredReusableCell(using: systemCellRegistration, for: indexPath, item: itemIdentifier)
            case .songs:
                return collectionView.dequeueConfiguredReusableCell(using: leftCheckmarkedCellRegistration, for: indexPath, item: itemIdentifier)
            case .ringtones:
                return collectionView.dequeueConfiguredReusableCell(using: leftCheckmarkedCellRegistration, for: indexPath, item: itemIdentifier)
            case .no:
                return collectionView.dequeueConfiguredReusableCell(using: valueCellRegistration, for: indexPath, item: itemIdentifier)
            }
        }
        
        setEmptyHeader()
        
        var snapshot = SnapshotType()
        for section in SectionType.allCases {
            snapshot.appendSections([section])
            snapshot.appendItems(cellsData[section] ?? [])
        }
        dataSource.apply(snapshot)
        
    }
    
    func setEmptyHeader() {
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<TitleSupplementaryView>(elementKind: UICollectionView.elementKindSectionHeader) {
            (supplementaryView, string, indexPath) in
            supplementaryView.label.text = SectionType.allCases[indexPath.section].rawValue
        }
        
        dataSource?.supplementaryViewProvider = { (collectionView, kind, indexPath)  in
            return collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryRegistration, for: indexPath)
        }
    }
    
    func fillCells() {
        cellsData = [
            .vibration: [CellData(cellType: .value,
                                  text: "Вибрация",
                                  secondaryText: alarm?.vibration?.title ?? "Не выбрана") { [weak self] in self?.toVibrationVC() }],
            
                .shop: [CellData(cellType: .standart, text: "Магазин звуков") { [weak self] in self?.toVibrationVC() },
                        CellData(cellType: .standart, text: "Загрузить купленные звуки") { [weak self] in self?.toVibrationVC() }],
            
                .songs: [CellData(cellType: .leftCheckmark, text: "Пение птиц Весной (Звуки Природы)"),
                         CellData(cellType: .leftCheckmarkWithDisclosure, text: "Выбор песни") { [weak self] in self?.toVibrationVC() }],
            
                .ringtones: [CellData(cellType: .leftCheckmark, text: "Радар (по умолчанию)"),
                             CellData(cellType: .leftCheckmark, text: "Апекс"),
                             CellData(cellType: .leftCheckmark, text: "Вершина"),
                             CellData(cellType: .leftCheckmark, text: "Вестник"),
                             CellData(cellType: .leftCheckmark, text: "Волны"),
                             CellData(cellType: .leftCheckmark, text: "Вступление"),
                             CellData(cellType: .leftCheckmark, text: "Грезы"),
                             CellData(cellType: .leftCheckmark, text: "Зыбь"),
                             CellData(cellType: .leftCheckmark, text: "Иллюминация"),
                             CellData(cellType: .leftCheckmark, text: "Космос"),
                             CellData(cellType: .leftCheckmark, text: "Кристаллы"),
                             CellData(cellType: .leftCheckmark, text: "Маяк"),
                             CellData(cellType: .leftCheckmark, text: "Медленно в гору"),
                             CellData(cellType: .leftCheckmark, text: "Мерцание"),
                             CellData(cellType: .leftCheckmark, text: "Обрыв"),
                             CellData(cellType: .leftCheckmark, text: "Отражение"),
                             CellData(cellType: .leftCheckmark, text: "Перезвон"),
                             CellData(cellType: .leftCheckmark, text: "Подъем"),
                             CellData(cellType: .leftCheckmark, text: "Позывной"),
                             CellData(cellType: .leftCheckmark, text: "Полуночник"),
                             CellData(cellType: .leftCheckmark, text: "Прогулка у моря"),
                             CellData(cellType: .leftCheckmark, text: "Свечение"),
                             CellData(cellType: .leftCheckmark, text: "Сентя"),
                             CellData(cellType: .leftCheckmark, text: "Скорей, скорей"),
                             CellData(cellType: .leftCheckmark, text: "Созвездие"),
                             CellData(cellType: .leftCheckmark, text: "Час потехи"),
                             CellData(cellType: .leftCheckmark, text: "Шелк"),
                             CellData(cellType: .leftCheckmark, text: "Электросхема"),
                             CellData(cellType: .leftCheckmarkWithDisclosure, text: "Классические") { [weak self] in self?.toVibrationVC() }
                            ],
            
                .no: [CellData(cellType: .leftCheckmark, text: "Нет")]
        ]
    }
    
    func toVibrationVC() {
        
    }
    
}
