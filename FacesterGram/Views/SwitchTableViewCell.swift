//
//  SwitchTableViewCell.swift
//  FacesterGram
//
//  Created by Ana Ma on 11/5/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

protocol SwitchCellDelegate: class {
    func selectionDidChange(option: String, value: Bool)
}

class SwitchTableViewCell: UITableViewCell {
    internal static let cellIdentifier: String = "SwitchCell"
    internal weak var delegate: SwitchCellDelegate?
    
    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var selectionSwitch: UISwitch!
    
    internal func updateElements(key: String, value: Bool) {
        self.optionLabel.text = key
        self.selectionSwitch.isOn = value
    }
    
    @IBAction func selectionSwitchDidChange(_ sender: UISwitch) {
        self.delegate?.selectionDidChange(option: optionLabel.text!, value: sender.isOn)
    }
}
