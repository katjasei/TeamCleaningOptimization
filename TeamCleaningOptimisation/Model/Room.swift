//
//  Room.swift
//  TeamCleaningOptimisation
//
//  Created by Oona on 9.4.2020.
//  Copyright © 2020 TeamCleaningOptimization. All rights reserved.
//
//  Created with https://app.quicktype.io/

import Foundation

//   let rooms = try? newJSONDecoder().decode(Rooms.self, from: jsonData)

struct Room {
    let floorId, roomID: String
    let dirtIndex: Double
    //let lastUpdate: Date
    //let lastCleaned: Int
    let roomType: String
}

typealias Rooms = [Room]
