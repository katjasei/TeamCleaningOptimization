//
//  Report.swift
//  TeamCleaningOptimization
//
//  Created by Katja on 29.3.2020.
//  Copyright © 2020 TeamCleaningOptimization. All rights reserved.
//

struct Report {
    
    let cleanerName: String // if use authentication
    let cleanIndex: Int
    let timeCleaningTook: Double
    let timeOfCleaning: String
    let wasCleaningSuccessfull: Bool
    let cleanerComment: String
    let heatmapCleaned: Int //should be binary
  
    
    init(cleanerName: String, cleanIndex: Int, timeCleaningTook: Double, timeOfCleaning: String, wasCleaningSuccessfull: Bool, cleanerComment: String, heatmapCleaned:Int) {
        
        self.cleanerName = cleanerName
        self.cleanIndex = cleanIndex
        self.timeCleaningTook = timeCleaningTook
        self.timeOfCleaning = timeOfCleaning
        self.wasCleaningSuccessfull = wasCleaningSuccessfull
        self.cleanerComment = cleanerComment
        self.heatmapCleaned = heatmapCleaned
        
    
    }
}
