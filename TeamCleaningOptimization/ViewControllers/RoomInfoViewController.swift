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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
        self.title = "Room " + String(getNumber)
        changeButtons()
    }
    
    //MARK: Actions

    @IBOutlet weak var startButton: RoundButton!
    @IBAction func startButtonClicked(_ sender: UIButton) {
        isCleaning = true
        changeButtons()
    }
    
    @IBOutlet weak var cleanedButton: RoundButton!
    @IBAction func cleanedButtonClicked(_ sender: UIButton) {
        isCleaning = false
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

