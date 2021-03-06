//
//  AlarmClockView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 07.02.2022.
//

import UIKit

protocol AlarmClockViewDelegate: AnyObject {
    func deleteAlarm(at indexPath: IndexPath)
}

class AlarmClockView: UIView {
    
    weak var delegate: AlarmClockViewDelegate?
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.showsVerticalScrollIndicator = false

        return collectionView
    }()
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {

        let layout = UICollectionViewCompositionalLayout() { sectionIndex, layoutEnvironment in
            var config = UICollectionLayoutListConfiguration(appearance: .grouped)
            config.headerMode = .supplementary

            config.trailingSwipeActionsConfigurationProvider = { indexPath in
                
                guard indexPath != IndexPath(row: 0, section: 0) else {
                    
                    return nil
                }
                
                let delete = UIContextualAction(style: .destructive, title: "Удалить") {
                    [weak self] action, view, completion in
                    
                    self?.delegate?.deleteAlarm(at: indexPath)
                    completion(true)
                }
                
                return UISwipeActionsConfiguration(actions: [delete])
            }

            config.itemSeparatorHandler = { (indexPath, sectionSeparatorConfiguration) in
                var configuration = sectionSeparatorConfiguration
                
                let inset = NSDirectionalEdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0)
                
                configuration.bottomSeparatorInsets = inset
                configuration.topSeparatorInsets = inset
                
                return configuration
            }
            
            let section = NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)

            return section
        }
        
        return layout
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AlarmClockView {
    
    func setupView() {
        addSubview(collectionView)
    }
    
}
