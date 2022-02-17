//
//  TimeZoneViewController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 16.02.2022.
//

import UIKit

class TimeZoneViewController: UIViewController {
    
    private lazy var timeZoneView: UIView = {
        let view = TimeZoneView()
        view.timeZoneTableView.tableHeaderView = searchController.searchBar
        return view
    }()
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchBar.setShowsCancelButton(true, animated: false)
        searchController.searchBar.isTranslucent = false
        searchController.delegate = self
        return searchController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        navigationItem.title = "Выбрать город"
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
     
        view.addSubview(timeZoneView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            timeZoneView.topAnchor.constraint(equalTo: view.topAnchor),
            timeZoneView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            timeZoneView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            timeZoneView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    @objc private func didTapCancelButton() {
        
    }
    
}

extension TimeZoneViewController: UISearchBarDelegate, UISearchControllerDelegate {
    
    
    
}
