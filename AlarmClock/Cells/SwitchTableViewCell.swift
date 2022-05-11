//
//  DefaultCellWithAccessorySwitch.swift
//  AlarmClock
//
//  Created by Кирилл  Геллерт on 11.05.2022.
//

import UIKit

protocol SwitchTableViewCellDelegate: AnyObject {
    func didAccessorySwitchValueChange(isOn: Bool)
}

class SwitchTableViewCell: UITableViewCell {

    weak var delegate: SwitchTableViewCellDelegate?
    
    private lazy var accessorySwitch: UISwitch = {
        let aSwitch = UISwitch()
        aSwitch.addTarget(self, action: #selector(didAccessorySwitchValueChange), for: .valueChanged)

        return aSwitch
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default,
                   reuseIdentifier: DefaultTableViewCell.reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String, switchIsOn: Bool) {
        var config = defaultContentConfiguration()
        config.text = text
        contentConfiguration = config
        accessorySwitch.isOn = switchIsOn
        accessoryView = accessorySwitch
    }

}

private extension SwitchTableViewCell {
    
    @objc func didAccessorySwitchValueChange(_ sender: UISwitch) {
        delegate?.didAccessorySwitchValueChange(isOn: sender.isOn)
    }
    
    func setupView() {
        backgroundColor = K.Color.staticTableViewBackground
        tintColor = .systemOrange
        accessoryType = .disclosureIndicator
        selectionStyle = .none
    }
    
}
