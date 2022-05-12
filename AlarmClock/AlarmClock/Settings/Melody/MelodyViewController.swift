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

extension MelodyViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch sections[indexPath.section].items[indexPath.row] {
        case .valueCell(let model):
            model.handler()
        case .defaultCell(let model):
            model.handler()
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
                .valueCell(options: ValueCellOption(text: "Пение Птиц Весной (Звуки Природы)",
                                                    secondaryText: "") { [weak self] in self?.toVibrationVC() }),
                .valueCell(options: ValueCellOption(text: "Выбор песни",
                                                    secondaryText: "") { [weak self] in self?.toVibrationVC() })
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
