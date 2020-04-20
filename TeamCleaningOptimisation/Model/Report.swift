//
//  Report.swift
//  TeamCleaningOptimization
//
//  Created by Katja on 29.3.2020.
//  Copyright © 2020 TeamCleaningOptimization. All rights reserved.
//

struct Report: Codable {
    
    let reportID: String
    let forRoomID: String
    let cleanerName: String
    let timeOfCleaning: Int
    let wasCleaningSuccessful: Bool
    let cleanerComments: String
    
    enum CodingKeys: String, CodingKey {
        case reportID = "report_id"
        case forRoomID = "for_room_id"
        case cleanerName = "cleaner_name"
        case timeOfCleaning = "time_of_cleaning"
        case wasCleaningSuccessful = "was_cleaning_successful"
        case cleanerComments = "cleaner_comments"
    }
}

typealias Reports = [Report]
