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
        
        self.title = "Room " + String(getNumber)
        changeButtons()
    }
    
    // Timer calls this every second
    @objc func countTime() {
        time += 1
        print(time)
    }
    
    //MARK: Actions

    @IBOutlet weak var startButton: RoundButton!
    @IBAction func startButtonClicked(_ sender: UIButton) {
        isCleaning = true
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countTime), userInfo: nil, repeats: true)
        changeButtons()
    }
    
    @IBOutlet weak var cleanedButton: RoundButton!
    @IBAction func cleanedButtonClicked(_ sender: UIButton) {
        isCleaning = false
        timer.invalidate()
        print("Timer stopped")
        changeButtons()
    }
    
    @IBAction func scheduleButtonClicked(_ sender: UIButton) {
    }
    
    func changeButtons() {
        if isCleaning {
            cleanedButton.isHidden = false
            startButton.isHidden = true
        }
        else {
            cleanedButton.isHidden = true
            startButton.isHidden = false
        }
    }
}

