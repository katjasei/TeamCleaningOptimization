//
//  BigReportController.swift
//  TeamCleaningOptimisation
//
//  Created by Oona on 14.4.2020.
//  Copyright © 2020 TeamCleaningOptimization. All rights reserved.
//

import UIKit

// Currently displays all reports from all cleaners

class BigReportViewController: UIViewController {
    
    // IB & Variables
    
    var successCount = 0
    var unsuccessCount = 0
    
    @IBOutlet weak var totalRoomsLabel: UILabel!
    @IBOutlet weak var totalSuccessfulLabel: UILabel!
    @IBOutlet weak var totalUnsuccessfulLabel: UILabel!
    @IBAction func onClickOkButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    var reports: Reports = [] {
        // Property observer, do this when value changes
        didSet {
            DispatchQueue.main.async {
                self.displayData()
            }
        }
    }
    private var totalRooms: Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doAPICall()
    }
    
    private func doAPICall() {
        let apiRequest = APIRequest()
        do {
           try apiRequest.getReports(completion: { result in
                switch result {
                case .success(let reports) :
                    self.reports = reports
                case .failure(let error) : print(error)
                }})
        
          } catch {
              print("Error getting data from API")
          }
    }
    
    private func countTotalData() {
        // Make array of room IDs
        for report in reports {
            totalRooms.append(report.forRoomID)
        }
        
        // Count successful and unsuccessful cleaning events
        for report in reports {
            if report.wasCleaningSuccessful {
                successCount += 1
            } else {
                unsuccessCount += 1
            }
        }
    }
    
    private func displayData() {
        countTotalData()
        totalRoomsLabel?.text = "\(totalRooms.count)"
        totalSuccessfulLabel?.text = "\(successCount)"
        totalUnsuccessfulLabel?.text = "\(unsuccessCount)"
    }
}
