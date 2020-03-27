//
//  TableViewCell.swift
//  TeamCleaningOptimization
//
//  Created by iosdev on 27.3.2020.
//  Copyright © 2020 TeamCleaningOptimization. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell{
    
    @IBOutlet weak var roomNumberLabel: UILabel!
    @IBOutlet weak var roomIndexLabel: UILabel!
    
    func updateContent(with number: Int, and index: Int) {
        roomNumberLabel.text = String(number)
        roomIndexLabel.text = String(index)
    }
}
