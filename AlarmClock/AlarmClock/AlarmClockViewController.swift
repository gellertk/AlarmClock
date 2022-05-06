//
//  AlarmClockViewController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.02.2022.
//

import UIKit

class AlarmClockViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    private let alarmClockView = AlarmClockView()
    
    private var dataSource: AlarmDataSource!
    
    override func loadView() {
        view = alarmClockView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Будильник"
        setupNavigationBarItems()
        setupDelegates()
        setupDataSource()
        reloadData()
    }
    
}

private extension AlarmClockViewController {
    
    func setupDelegates() {
        alarmClockView.alarmsTableView.delegate = self
    }
    
    private func setupDataSource() {
        dataSource = AlarmDataSource(tableView: alarmClockView.alarmsTableView,
                                     cellProvider: { [weak self] (tableView, indexPath, alarm) -> UITableViewCell? in
            if let cell = self?.alarmClockView.alarmsTableView.dequeueReusableCell(withIdentifier: AlarmClockTableViewCell.reuseId) as? AlarmClockTableViewCell {
                cell.configure(alarm: alarm)
                
                return cell
            }
            
            return nil
        })
    }
    
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
            self.alarmClockView.alarmsTableView.isEditing.toggle()
            //            self.alarmClockView.alarmsTableView.layoutMargins = UIEdgeInsets(top: 0,
            //                                                                        left: 20,
            //                                                                        bottom: 0,
            //                                                                        right: 0)
            
        }
        
        //alarmClockView.alarmsTableView.allowsSelection.toggle()
    }
    
    @objc func didTapAddButton() {
        present(UINavigationController(rootViewController: AlarmSettingsViewController(alarm: Alarm.createDefault()), withLargeTitle: false), animated: true)
    }
    
    func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<AlarmCategory, Alarm>()
        for category in AlarmCategory.allCases {
            let items = Alarm.getAlarms().filter { $0.category == category }
            snapshot.appendSections([category])
            snapshot.appendItems(items)
        }
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
    
}

extension AlarmClockViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView = AlarmClockSectionHeaderView()
        sectionView.setSection(section: section)
        
        return sectionView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.section == 0 {
            return .none
        } else {
            return .delete
        }
    }
    
}
