//
//  PresentationService.swift
//  TeamCleaningOptimisation
//
//  Created by Oona on 16.4.2020.
//  Copyright © 2020 TeamCleaningOptimization. All rights reserved.
//

import UIKit


class StatusReportPresentationPresentationService {
    
    func present() -> StatusReportViewController {
        let storyboard = UIStoryboard(name: "StatusReport", bundle: .main)
        
        let viewController = storyboard.instantiateViewController(identifier: "StatusReport") as!
            StatusReportViewController
        
        return viewController
    }
}
