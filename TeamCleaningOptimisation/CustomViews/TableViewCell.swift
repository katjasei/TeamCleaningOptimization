//
//  TableViewCell.swift
//  TeamCleaningOptimization
//
//  Created by Oona on 27.3.2020.
//  Copyright © 2020 TeamCleaningOptimization. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell{
    
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var designView: DesignView!
    @IBOutlet weak var roomNumberLabel: UILabel!
    @IBOutlet weak var roomIndexLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func updateContent(roomID number: String, roomIndex index: Int) {
        roomNumberLabel.text = number
        roomIndexLabel.text = String(index)
    }
    func updateBackgroundColour(colour: UIColor) {
        innerView.backgroundColor = colour
        designView.backgroundColor = colour
    }
}
