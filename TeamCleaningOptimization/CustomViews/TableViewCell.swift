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
    
    func updateContent(with number: String, and index: Int) {
        roomNumberLabel.text = number
        roomIndexLabel.text = String(index)
    }
}
