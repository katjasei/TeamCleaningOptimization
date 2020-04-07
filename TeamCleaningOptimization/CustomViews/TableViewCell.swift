//
//  TableViewCell.swift
//  TeamCleaningOptimization
//
//  Created by Oona on 27.3.2020.
//  Copyright © 2020 TeamCleaningOptimization. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell{
    
    @IBOutlet weak var roomNumberLabel: UILabel!
    @IBOutlet weak var roomIndexLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    func updateContent(with number: Int, and index: Int, and time: String) {
        roomNumberLabel.text = String(number)
        roomIndexLabel.text = String(index)
        timeLabel.text = time
    }
}
