//
//  RoomInfo.swift
//  TeamCleaningOptimization
//
//  Created by Katja on 28.3.2020.
//  Copyright © 2020 TeamCleaningOptimization. All rights reserved.
//

struct RoomInfo {
    
    let roomType: String
    let index: Int
    let sinceLastCleaned: String //should be time
    let movementInTheRoom: Bool
    let patientInRoom: Bool
  
    
    init(roomType: String, index: Int, sinceLastCleaned: String, movementInTheRoom: Bool,  patientInRoom:Bool) {
        
        self.roomType = roomType
        self.index = index
        self.sinceLastCleaned = sinceLastCleaned
        self.movementInTheRoom = movementInTheRoom
        self.patientInRoom = patientInRoom
        
    }
}
