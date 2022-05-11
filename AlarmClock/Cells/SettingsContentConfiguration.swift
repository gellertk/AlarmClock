////
////  SettingsContentConfiguration.swift
////  AlarmClock
////
////  Created by Кирилл  Геллерт on 08.05.2022.
////
//
//import UIKit
//
//struct SettingsContentConfiguration : UIContentConfiguration {
//    
//    var text = ""
//    
//    func makeContentView() -> UIView & UIContentView {
//        return SettingsContentView(self)
//    }
//    
//    func updated(for state: UIConfigurationState) -> SettingsContentConfiguration {
//        return self
//    }
//    
//}
//
//class SettingsContentView : UIView, UIContentView {
//    
//    var configuration: UIContentConfiguration {
//        didSet {
//            configure(configuration: configuration)
//        }
//    }
//    
//    private let leadingLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .left
//        
//        
//        return label
//    }()
//    
//    private let trailingLabel: UILabel = {
//        let label = UILabel()
//        //label.textAlignment = .left
//        
//        return label
//    }()
//    
//    init(_ configuration: UIContentConfiguration) {
//        self.configuration = configuration
//        super.init(frame: .zero)
//        setupView()
//        configure(configuration: configuration)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    func configure(configuration: UIContentConfiguration) {
//        guard let configuration = configuration as? SettingsContentConfiguration else { return }
//        leadingLabel.text = configuration.text
//    }
//}
//
//private extension SettingsContentView {
//    
//    func setupView() {
//        [leadingLabel, trailingLabel].forEach {
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            addSubview($0)
//        }
//        setupConstraints()
//    }
//    
//    func setupConstraints() {
//        NSLayoutConstraint.activate([
//            leadingLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
//            leadingLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
//            leadingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
//            leadingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
//        ])
//    }
//    
//}
