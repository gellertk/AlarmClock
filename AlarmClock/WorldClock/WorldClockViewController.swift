//
//  ViewController.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.02.2022.
//

import UIKit

class WorldClockViewController: UIViewController {
    
    private var worldClocks: [WorldClock] = []
    
    private lazy var worldClockView: WorldClockView = {
        let view = WorldClockView()
        view.worldClockTableView.delegate = self
        view.worldClockTableView.dataSource = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Мировые часы"
        setupView()
    }
    
    @objc private func didTapEditButton() {
        
    }
    
    @objc private func didTapAddButton() {
        
    }
    
    private func setupView() {
        [worldClockView].forEach { newView in
            newView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(newView)
        }
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            worldClockView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            worldClockView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            worldClockView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            worldClockView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}

extension WorldClockViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return worldClocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellId, for: indexPath) as? WorldClockTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
}
