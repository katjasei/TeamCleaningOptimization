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

struct Room: Codable {
    let floorId, roomID: String
    let dirtIndex: Int
    let dirtHeatmap, movHeatmap: String
    let lastUpdate: Int

    enum CodingKeys: String, CodingKey {
        case floorId = "floor_id"
        case roomID = "room_id"
        case dirtIndex = "dirt_index"
        case dirtHeatmap = "dirt_heatmap"
        case movHeatmap = "mov_heatmap"
        case lastUpdate = "last_update"
    }
}
