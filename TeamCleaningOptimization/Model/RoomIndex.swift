//
//  RoomIndex.swift
//  TeamCleaningOptimization
//
//  Created by Artur Kulagin on 27.3.2020.
//  Copyright © 2020 TeamCleaningOptimization. All rights reserved.
//

import Foundation

class RoomIndex {
    
    var room: Int
    var index: Int
    
//    var heatmap_dirty: binary
//    var is_cleaning: bool
    
    init(room: Int, index: Int) {
        self.room   = room
        self.index  = index
    }
    
    func getColor(index: Int) {
        
       // var color = "orange"
        
        if index < 33 {
            //color = "green"
        } else if index > 66 {
            //color = "red"
        }
    }
}
