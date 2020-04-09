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
    let id, roomID: String
    let dirtIndex: Int
    let dirtHeatmap, movHeatmap: Heatmap
    let lastUpdate: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case roomID = "room_id"
        case dirtIndex = "dirt_index"
        case dirtHeatmap = "dirt_heatmap"
        case movHeatmap = "mov_heatmap"
        case lastUpdate = "last_update"
    }
}
