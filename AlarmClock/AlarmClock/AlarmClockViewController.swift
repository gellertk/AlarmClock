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
        setupDelegates()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Будильник"
        reloadData()
        setupNavigationController()
        setupDataSource()
    }
    
}

private extension AlarmClockViewController {
    
    private func setupDataSource() {
        dataSource = AlarmDataSource(tableView: alarmClockView.alarmsTableView,
                                     cellProvider: { [weak self] (tableView, indexPath, alarm) -> UITableViewCell? in
            if let cell = self?.alarmClockView.alarmsTableView.dequeueReusableCell(withIdentifier: AlarmClockTableViewCell.reuseId) as? AlarmClockTableViewCell {
                cell.setupContent(alarm: alarm)
                
                return cell
            }
            
            return nil
        })
    }
    
    func setupNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = K.Color.secondaryInterface
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.topItem?.setLeftBarButton(UIBarButtonItem(title: "Править",
                                                                                      style: .plain,
                                                                                      target: self,
                                                                                      action: #selector(didTapEditButton)), animated: false)
        navigationController?.navigationBar.topItem?.setRightBarButton(UIBarButtonItem(image: K.SystemImage.plus,
                                                                                       style: .plain,
                                                                                       target: self,
                                                                                       action: #selector(didTapAddButton)), animated: false)
    }
    
    @objc private func didTapEditButton() {
        
    }
    
    @objc func didTapAddButton(_ sender: UIBarButtonItem) {
        
    }
    
    func setupDelegates() {
        alarmClockView.alarmsTableView.delegate = self
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            var snapshot = NSDiffableDataSourceSnapshot<AlarmCategory, Alarm>()
            for category in AlarmCategory.allCases {
                let items = Alarm.getAlarms().filter { $0.category == category }
                snapshot.appendSections([category])
                snapshot.appendItems(items)
            }
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
    
}

extension AlarmClockViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        view.backgroundColor = .blue
        
        return view
    }
    
}
