//
//  File.swift
//  TeamCleaningOptimization
//
//  Created by Artur Kulagin on 27.3.2020.
//  Copyright © 2020 TeamCleaningOptimization. All rights reserved.
//

import Foundation

class RoomIndex {
    
    var room: Int
    var index: Int
    
    init(room: Int, index: Int) {
        self.room   = room
        self.index  = index
    }
    
    func getColor(index: Int) {
        if index < 33 {
//            return green
        }else if index < 66 {
//            return orange
        }else if index <= 100 {
//            return red
        }
    }
}
