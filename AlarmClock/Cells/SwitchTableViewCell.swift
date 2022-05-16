//
//  DefaultCellWithAccessorySwitch.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 11.05.2022.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    
    var model: SwitchCellOption?
    
    private lazy var accessorySwitch: UISwitch = {
        let aSwitch = UISwitch()
        aSwitch.addTarget(self, action: #selector(didSwitchCellValueChange), for: .valueChanged)

        return aSwitch
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default,
                   reuseIdentifier: "")
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with options: SwitchCellOption) {
        self.model = options
        var config = defaultContentConfiguration()
        config.text = options.text
        contentConfiguration = config
        accessorySwitch.isOn = options.isOn
        accessoryView = accessorySwitch
    }

}

private extension SwitchTableViewCell {
    
    @objc func didSwitchCellValueChange(_ sender: UISwitch) {
        model?.handler()
    }
    
    func setupView() {
        backgroundColor = K.Color.staticTableViewBackground
        tintColor = .systemOrange
        accessoryType = .disclosureIndicator
        selectionStyle = .none
    }
    
}
