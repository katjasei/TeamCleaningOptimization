//
//  PresentationService.swift
//  TeamCleaningOptimisation
//
//  Created by Oona on 16.4.2020.
//  Copyright © 2020 TeamCleaningOptimization. All rights reserved.
//

import UIKit


class BigReportPresentationPresentationService {
    
    func present() -> BigReportViewController {
        let storyboard = UIStoryboard(name: "BigReport", bundle: .main)
        
        let viewController = storyboard.instantiateViewController(identifier: "bigReport") as!
            BigReportViewController
        
        return viewController
    }
}
