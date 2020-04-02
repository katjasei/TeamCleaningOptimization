//
//  RoomIndex.swift
//  TeamCleaningOptimization
//
//  Created by Artur Kulagin on 27.3.2020.
//  Copyright © 2020 TeamCleaningOptimization. All rights reserved.
//

import UIKit

class RoomIndex {
    
    var room: Int
    var index: Int
    
//    var heatmap_dirty: binary
//    var is_cleaning: bool
    
    init(room: Int, index: Int) {
        self.room   = room
        self.index  = index
    }
    
    func getColor(index: Int) -> UIColor {
        
        var color = UIColor.red
        
        if index < 33 {
            color = UIColor.blue
        } else if index > 66 {
            color = UIColor.yellow
    }
        return color
}
    
}

