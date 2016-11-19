//
//  SegmentedTableViewCell.swift
//  FacesterGram
//
//  Created by Ana Ma on 11/1/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

protocol SegmentedCellDelegate: class {
    func segmentValueChanged(_ value: Int)
}

class SegmentedTableViewCell: UITableViewCell {
    
    internal weak var delegate: SegmentedCellDelegate?
    
    static let cellIdentifier = "SegmentedCell"
    
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func genderSegmentedControlTapped(_ sender: UISegmentedControl) {
        print("Segmented control changed")
        print("\(sender.selectedSegmentIndex)")
        self.delegate?.segmentValueChanged(sender.selectedSegmentIndex)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
