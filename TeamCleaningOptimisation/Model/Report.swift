//
//  Report.swift
//  TeamCleaningOptimization
//
//  Created by Katja on 29.3.2020.
//  Copyright © 2020 TeamCleaningOptimization. All rights reserved.
//

class Report: Codable {
    
    let reportID: String
    let forRoomID: String
    let cleanerName: String
    //let timeOfCleaning: String
    let wasCleaningSuccessful: Bool
    let cleanerComments: String
    
    enum CodingKeys: String, CodingKey {
        case reportID = "report_id"
        case forRoomID = "for_room_id"
        case cleanerName = "cleaner_name"
        //case timeOfCleaning = "time_of_cleaning"
        case wasCleaningSuccessful = "was_cleaning_successful"
        case cleanerComments = "cleaner_comments"
    }
    
    init(reportID: String, forRoomID: String, cleanerName: String,
         //timeOfCleaning: String,
         wasCleaningSuccessful: Bool, cleanerComments: String) {
        
        self.reportID = reportID
        self.forRoomID = forRoomID
        self.cleanerName = cleanerName
        //self.timeOfCleaning = timeOfCleaning
        self.wasCleaningSuccessful = wasCleaningSuccessful
        self.cleanerComments = cleanerComments
        
    }
}

typealias Reports = [Report]
