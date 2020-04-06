//
//  ViewController.swift
//  TeamCleaningOptimization
//
//  Created by Katja on 25.3.2020.
//  Copyright © 2020 TeamCleaningOptimization. All rights reserved.
//

import UIKit

class RoomInfoViewController: UIViewController {
    
    var isCleaning = false
    var getNumber = Int()
    var timer: Timer!
    var time = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.isHidden = true
        self.title = "Room " + String(getNumber)
        changeButtons()
    }
    
    // Timer calls this every second
    @objc func countTime() {
        time += 1
        timeLabel.text = String(time)
        print(time)
    }
    
    // Changes start and stop cleaning buttons. Disables back navigation for timer to work correctly
    func changeButtons() {
        if isCleaning {
            self.navigationItem.hidesBackButton = true
            cleanedButton.isHidden = false
            startButton.isHidden = true
        }
        else {
            self.navigationItem.hidesBackButton = false
            cleanedButton.isHidden = true
            startButton.isHidden = false
        }
    }
    
    // Pass room data to report
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showReport" {
            let destinationViewController = segue.destination as! ReportViewController
            destinationViewController.roomNumb = self.getNumber
            destinationViewController.time = self.time
        }
    }
    
    //MARK: Actions

    @IBOutlet weak var startButton: RoundButton!
    @IBAction func startButtonClicked(_ sender: UIButton) {
        isCleaning = true
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countTime), userInfo: nil, repeats: true)
        timeLabel.isHidden = false
        changeButtons()
    }
    
    @IBOutlet weak var cleanedButton: RoundButton!
    @IBAction func cleanedButtonClicked(_ sender: UIButton) {
        isCleaning = false
        timer.invalidate()
        print("Timer stopped")
        changeButtons()
        self.performSegue(withIdentifier: "showReport", sender: "cleanedButton")
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBAction func scheduleButtonClicked(_ sender: UIButton) {
    }
}

