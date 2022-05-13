//
//  AlarmMelodyViewController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 09.05.2022.
//

import UIKit

class MelodyViewController: UIViewController {
    
    weak var delegate: AlarmUpdateDelegate?
    
    private var alarm: Alarm?
    
    private let alarmMelodyView = MelodyView()
    
    private var sections: [MelodySection] = []
    
    lazy var dataSource = MelodyDataSource(tableView: alarmMelodyView.tableView) { tableView, indexPath, item in
        
        switch item {
        case .valueCell(let options):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ValueTableViewCell.reuseIdentifier, for: indexPath) as? ValueTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: options)
            
            return cell
        case .defaultCell(let options):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DefaultTableViewCell.reuseIdentifier, for: indexPath) as? DefaultTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: options)
            
            return cell
        case .checkmarkedCell(let options):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LeftCheckmarkTableViewCell.reuseIdentifier, for: indexPath) as? LeftCheckmarkTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: options)
            
            return cell
        default:
            return UITableViewCell()
        }
        
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
        fillCells()
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

class MelodyDataSource: UITableViewDiffableDataSource<MelodySection, CellType> {
    
    var sections: [MelodySection] = []
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sections[section].title
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 1 {
            return K.String.footerForShopSection
        }
        
        return nil
    }
            
}

extension MelodyViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch sections[indexPath.section].items[indexPath.row] {
        case .valueCell(let options):
            options.handler()
        case .defaultCell(let options):
            options.handler()
        case .checkmarkedCell:
            if let cell = tableView.cellForRow(at: indexPath) as? LeftCheckmarkTableViewCell {
                //cell.toggleLeftCheckmark()
            }
        default:
            break
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

private extension MelodyViewController {
    
    func fillCells() {
        sections = [
            MelodySection(title: "", items: [
                .valueCell(options: ValueCellOption(text: "Вибрация",
                                                    secondaryText: "Не выбрана") { [weak self] in self?.toVibrationVC() })
            ]),
            MelodySection(title: "МАГАЗИН", items: [
                .defaultCell(options: DefaultCellOption(text: "Магазин звуков",
                                                        textColor: .systemOrange) { [weak self] in self?.toVibrationVC() }),
                .defaultCell(options: DefaultCellOption(text: "Загрузить все купленные звуки",
                                                        textColor: .systemOrange) { [weak self] in self?.toVibrationVC() })
            ]),
            MelodySection(title: "ПЕСНИ", items: [
                .checkmarkedCell(options: CheckmarkCellOption(text: "Пение Птиц Весной (Звуки Природы)",
                                                              isCheckmarked: true) { [weak self] in self?.toVibrationVC() }),
                .checkmarkedCell(options: CheckmarkCellOption(text: "Выбор песни",
                                                              isCheckmarked: false) { [weak self] in self?.toVibrationVC() })
            ]),
            MelodySection(title: "РИНГТОНЫ", items: [
                .checkmarkedCell(options: CheckmarkCellOption(text: "Радар (по умолчанию)",
                                                              isCheckmarked: false) { [weak self] in self?.toVibrationVC() }),
                .checkmarkedCell(options: CheckmarkCellOption(text: "Апекс",
                                                              isCheckmarked: false) { [weak self] in self?.toVibrationVC() }),
                .checkmarkedCell(options: CheckmarkCellOption(text: "Вершина",
                                                              isCheckmarked: false) { [weak self] in self?.toVibrationVC() }),
                .checkmarkedCell(options: CheckmarkCellOption(text: "Вестник",
                                                              isCheckmarked: false) { [weak self] in self?.toVibrationVC() }),
                .checkmarkedCell(options: CheckmarkCellOption(text: "Волны",
                                                              isCheckmarked: false) { [weak self] in self?.toVibrationVC() }),
                .checkmarkedCell(options: CheckmarkCellOption(text: "Вступление",
                                                              isCheckmarked: false) { [weak self] in self?.toVibrationVC() }),
                .checkmarkedCell(options: CheckmarkCellOption(text: "Грезы",
                                                              isCheckmarked: false) { [weak self] in self?.toVibrationVC() }),
                .checkmarkedCell(options: CheckmarkCellOption(text: "Зыбь",
                                                              isCheckmarked: false) { [weak self] in self?.toVibrationVC() }),
                .checkmarkedCell(options: CheckmarkCellOption(text: "Иллюминация",
                                                              isCheckmarked: false) { [weak self] in self?.toVibrationVC() }),
                .checkmarkedCell(options: CheckmarkCellOption(text: "Космос",
                                                              isCheckmarked: false) { [weak self] in self?.toVibrationVC() }),
                .checkmarkedCell(options: CheckmarkCellOption(text: "Кристалы",
                                                              isCheckmarked: false) { [weak self] in self?.toVibrationVC() }),
                .checkmarkedCell(options: CheckmarkCellOption(text: "Маяк",
                                                              isCheckmarked: false) { [weak self] in self?.toVibrationVC() }),
                .checkmarkedCell(options: CheckmarkCellOption(text: "Медленно в гору",
                                                              isCheckmarked: false) { [weak self] in self?.toVibrationVC() }),
                .checkmarkedCell(options: CheckmarkCellOption(text: "Мерцание",
                                                              isCheckmarked: false) { [weak self] in self?.toVibrationVC() }),
                .checkmarkedCell(options: CheckmarkCellOption(text: "Отражение",
                                                              isCheckmarked: false) { [weak self] in self?.toVibrationVC() }),
                .checkmarkedCell(options: CheckmarkCellOption(text: "Перезвон",
                                                              isCheckmarked: false) { [weak self] in self?.toVibrationVC() }),
                .checkmarkedCell(options: CheckmarkCellOption(text: "Подъем",
                                                              isCheckmarked: false) { [weak self] in self?.toVibrationVC() }),
                .checkmarkedCell(options: CheckmarkCellOption(text: "Позывной",
                                                              isCheckmarked: false) { [weak self] in self?.toVibrationVC() }),
                .checkmarkedCell(options: CheckmarkCellOption(text: "Полуночник",
                                                              isCheckmarked: false) { [weak self] in self?.toVibrationVC() }),
                .checkmarkedCell(options: CheckmarkCellOption(text: "Прогулка у моря",
                                                              isCheckmarked: false) { [weak self] in self?.toVibrationVC() }),
                .checkmarkedCell(options: CheckmarkCellOption(text: "Свечение",
                                                              isCheckmarked: false) { [weak self] in self?.toVibrationVC() }),
                .checkmarkedCell(options: CheckmarkCellOption(text: "Сентя",
                                                              isCheckmarked: false) { [weak self] in self?.toVibrationVC() }),
                .checkmarkedCell(options: CheckmarkCellOption(text: "Скорей, скорей",
                                                              isCheckmarked: false) { [weak self] in self?.toVibrationVC() }),
                .checkmarkedCell(options: CheckmarkCellOption(text: "Созвездие",
                                                              isCheckmarked: false) { [weak self] in self?.toVibrationVC() }),
                .checkmarkedCell(options: CheckmarkCellOption(text: "Час потехи",
                                                              isCheckmarked: false) { [weak self] in self?.toVibrationVC() }),
                .checkmarkedCell(options: CheckmarkCellOption(text: "Шелк",
                                                              isCheckmarked: false) { [weak self] in self?.toVibrationVC() }),
                .checkmarkedCell(options: CheckmarkCellOption(text: "Электросхема",
                                                              isCheckmarked: false) { [weak self] in self?.toVibrationVC() }),
                .checkmarkedCell(options: CheckmarkCellOption(text: "Классические",
                                                              isCheckmarked: false) { [weak self] in self?.toVibrationVC() })
            ]),
            
            MelodySection(title: "", items: [
                .checkmarkedCell(options: CheckmarkCellOption(text: "Нет",
                                                              isCheckmarked: true) { [weak self] in self?.toVibrationVC() })
            ])
        ]
        dataSource.sections = sections
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<MelodySection, CellType>()
        for section in sections {
            snapshot.appendSections([section])
            snapshot.appendItems(section.items)
        }
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
    
    func setupDelegates() {
        alarmMelodyView.tableView.delegate = self
    }
    
    func toVibrationVC() {
        guard let alarm = alarm else {
            return
        }
        //        let toVibrationVC = MelodyViewController(alarm: alarm)
        //        melodyVC.delegate = self
        //        navigationController?.pushViewController(melodyVC,
        //                                                 animated: true)
    }
    
}
