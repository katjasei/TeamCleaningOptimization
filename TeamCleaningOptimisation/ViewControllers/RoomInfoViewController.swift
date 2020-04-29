//
//  ViewController.swift
//  TeamCleaningOptimization
//
//  Created by Katja on 25.3.2020.
//  Copyright © 2020 TeamCleaningOptimization. All rights reserved.
//

import UIKit

class RoomInfoViewController: UIViewController {
    
    private var isCleaning = false
    private var timer: Timer!
    //make request every 10 sec
    private var timerForRequest: Timer!
    private var time = 0
    var room: Room!
    private var counter = 0
    @IBOutlet weak var heatMapImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var cleanedButton: RoundButton!
    
    // Demo image data
    private var imagesArray = [UIImage.init(named: "demo2_1"), UIImage.init(named: "demo2_2"), UIImage.init(named: "demo2_3"), UIImage.init(named: "demo2_4"), UIImage.init(named: "demo2_5"), UIImage.init(named: "demo2_6"), UIImage.init(named: "demo2_7"), UIImage.init(named: "demo2_8"), UIImage.init(named: "demo2_9"), UIImage.init(named: "demo2_10"), UIImage.init(named: "demo2_11"), UIImage.init(named: "demo2_12"), UIImage.init(named: "demo2_13") ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.isHidden = true
        self.title = "Room " + String(room.roomID)
        changeButtons()
        // Show dirty heatmap
        self.heatMapImageView.image = UIImage.init(named: "demo2_1")
        // API call
        let apiRequest = APIRequest()
        do {
        try apiRequest.getHeatmap(roomID: room.roomID, completionHandler: { contentLength in
            
                })
        } catch {
            print("Error getting data from API")
        }
    }
    
    // Timer calls this every second
    @objc func countTime() {
        time += 1
        timeLabel.text = String(time)
    }
    
    //timerForRequest calls this every 10 seconds
    @objc func updateMov_heatmap() {
        // API call
        let apiRequest = APIRequest()
        do {
        try apiRequest.getRoom(roomID: room.roomID ,completion: { result in
            switch result {
            case .success(let room) :
                print(room.movHeatmap)
                let convertedMov_heatmap = self.base64Convert(base64String: room.movHeatmap)
                DispatchQueue.main.async {
                    self.heatMapImageView.image = convertedMov_heatmap
                }
            case .failure(let error) :
                print(error)
                       }})
        } catch {
            print("Error getting data from API")
        }
    }
    
    //timerForRequest calls this every 10 seconds, for the demo version
    @objc func change_image() {
        
        if (imagesArray.count == counter) {
            timerForRequest.invalidate()
            counter = 0
         } else {
            self.heatMapImageView.image = imagesArray[counter]
            counter += 1
            print (counter)
        }
    }
    
    //MARK: Actions
    
    @IBOutlet weak var startButton: RoundButton!
    @IBAction func startButtonClicked(_ sender: UIButton) {
        isCleaning = true
        notifyStartCleaning()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countTime), userInfo: nil, repeats: true)
        changeButtons()
        //for demo version
        self.heatMapImageView.image = UIImage.init(named: "demo2_1")
        
        
        //update mov_heatmap every 10 seconds
        timerForRequest = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(change_image), userInfo: nil, repeats: true)
      }
    
    @IBAction func cleanedButtonClicked(_ sender: UIButton) {
        isCleaning = false
        notifyStopCleaning()
        timer.invalidate()
        // Stop to update mov_heatmap
        timerForRequest.invalidate()
        print("Timer stopped")
        changeButtons()
        self.performSegue(withIdentifier: "showReport", sender: "cleanedButton")
    }
    
    
    // Notifies database of cleaning event stop
    private func notifyStopCleaning() {
        let apiRequest = APIRequest()
        do {
            try apiRequest.putStopCleaning(roomID: room.roomID)
            print("Notified db of cleaning stop")
        } catch {
            print("Error notifying database of cleaning")
        }
    }
    
    private func notifyStartCleaning() {
        let apiRequest = APIRequest()
        do {
            try apiRequest.putStartCleaning(roomID: room.roomID)
            print("Notified db of cleaning start")
        } catch {
            print("Error notifying database of cleaning")
        }
    }
    
    // Converts heatmap data to images
    private func base64Convert(base64String: String?) -> UIImage{
      if (base64String?.isEmpty)! {
          return #imageLiteral(resourceName: "no_image_found")
      } else {
          let temp = base64String
          let dataDecoded : Data = Data(base64Encoded: temp!, options: .ignoreUnknownCharacters)!
          let decodedimage = UIImage(data: dataDecoded)
          return decodedimage!
      }
    }
    
    // Changes start and stop cleaning buttons. Disables back navigation for timer to work correctly
    private func changeButtons() {
        if isCleaning {
            self.navigationItem.hidesBackButton = true
            cleanedButton.isHidden = false
            startButton.isHidden = true
            //timeLabel.isHidden = false
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
            destinationViewController.roomNumb = room.roomID
            destinationViewController.time = self.time
        }
    }
}
