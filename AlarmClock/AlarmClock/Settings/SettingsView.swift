//
//  AlarmSettingsView.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 04.05.2022.
//

import UIKit

class SettingsView: UIView {
    
    private let timeDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .time
        datePicker.overrideUserInterfaceStyle = .dark
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.backgroundColor = K.Color.disabledBackground
        
        return datePicker
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.isScrollEnabled = false
        
        return collectionView
    }()
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout() { sectionIndex, layoutEnvironment in
            var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            config.headerMode = .supplementary
            
            let section = NSCollectionLayoutSection.list(using: config,
                                                         layoutEnvironment: layoutEnvironment)
            let headerSize = NSCollectionLayoutSize(widthDimension: .absolute(0.1),
                                                    heightDimension: .absolute(0.1))
            
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                            elementKind: UICollectionView.elementKindSectionHeader,
                                                                            alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]
            
            return section
        }
        
        return layout
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension SettingsView {
    
    func setupView() {
        overrideUserInterfaceStyle = .dark
        backgroundColor = K.Color.disabledBackground
        [timeDatePicker,
         collectionView
        ].forEach {
            addSubview($0)
        }
        setupConstraints()
    }
    
    func setupConstraints() {
        timeDatePicker.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.top.equalToSuperview().offset(50)
            $0.height.equalTo(220)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(timeDatePicker.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}
