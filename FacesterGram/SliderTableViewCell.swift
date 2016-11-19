//
//  SliderTableViewCell.swift
//  FacesterGram
//
//  Created by Ana Ma on 10/27/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import UIKit

protocol SliderCellDelegate: class {
    func sliderDidChange(_ value: Int)
}

class SliderTableViewCell: UITableViewCell {
    
    internal var delegate: SliderCellDelegate?
    
    static let cellIdentifier: String = "SliderCell"
    @IBOutlet weak var numberOfResultsLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    //    In this function, adjust the .minimum, .maximum and .value for the slider using the provided parameters
    //    Additionally, update the label text
    internal func updateSlider(min: Int, max: Int, current: Int){
        self.slider.minimumValue = Float(min)
        self.slider.maximumValue = Float(max)
        self.slider.setValue(Float(current), animated: true)
        
        self.numberOfResultsLabel.text = "\(current)"
        //when go back, there's no value stored
        //need to create a singleton
    }
    @IBAction func didChangeValue(_ sender: UISlider) {
        self.numberOfResultsLabel.text = "\(Int(sender.value))"
        self.delegate?.sliderDidChange(Int(sender.value))
        //SettingsManager.manager.updateNumberOfResults(Int(sender.value))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
