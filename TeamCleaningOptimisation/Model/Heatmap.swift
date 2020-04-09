//
//  Room.swift
//  TeamCleaningOptimisation
//
//  Created by Oona on 9.4.2020.
//  Copyright © 2020 TeamCleaningOptimization. All rights reserved.
//
//  Created with https://app.quicktype.io/

import Foundation

struct Heatmap: Codable {
    let binary, type: String

    enum CodingKeys: String, CodingKey {
        case binary = "$binary"
        case type = "$type"
    }
}
