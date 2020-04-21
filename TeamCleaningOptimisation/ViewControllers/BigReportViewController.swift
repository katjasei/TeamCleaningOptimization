//
//  BigReportController.swift
//  TeamCleaningOptimisation
//
//  Created by Oona on 14.4.2020.
//  Copyright © 2020 TeamCleaningOptimization. All rights reserved.
//

import UIKit

class BigReportViewController: UIViewController {
    
    // IB & Variables
    
    @IBAction func onClickOkButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBOutlet weak var roomsLabel: UILabel!
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
        for report in reports {
            totalRooms.append(report.forRoomID)
        }
    }
    
    private func displayData() {
        countTotalData()
        roomsLabel.text = "\(totalRooms)"
    }
}
