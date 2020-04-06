//
//  RoomIndex.swift
//  TeamCleaningOptimization
//
//  Created by Artur Kulagin on 27.3.2020.
//  Copyright © 2020 TeamCleaningOptimization. All rights reserved.
//

import UIKit

class RoomIndex {
    
    var room: String
    var index: Int
    var time: String
    
//    var heatmap_dirty: binary
//    var is_cleaning: bool
    
    init(room: String, index: Int, time: String) {
        self.room   = room
        self.index  = index
        self.time = time
    }
    
    func getColor(index: Int) -> UIColor {
        
        var color = UIColor.red
        
        if index <= 33 {
            color = UIColor.yellow
        } else if index >= 66 {
            color = UIColor.red
    } else  {
               color = UIColor.orange
       }
        return color
}
    
}

