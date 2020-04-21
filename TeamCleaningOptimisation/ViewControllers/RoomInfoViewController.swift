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
    var timer: Timer!
    //make request every 10 sec
    var timerForRequest:Timer!
    var time = 0
    var room: Room!
    var counter = 0
    @IBOutlet weak var heatMapImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scheduleButton: RoundButton!
    @IBOutlet weak var cleanedButton: RoundButton!
    
    // for demo
       var imagesArray = [UIImage.init(named: "demo2_1"), UIImage.init(named: "demo2_2"), UIImage.init(named: "demo2_3"), UIImage.init(named: "demo2_4"), UIImage.init(named: "demo2_5"), UIImage.init(named: "demo2_6"), UIImage.init(named: "demo2_7"), UIImage.init(named: "demo2_8"), UIImage.init(named: "demo2_9"), UIImage.init(named: "demo2_10"), UIImage.init(named: "demo2_11"), UIImage.init(named: "demo2_12"), UIImage.init(named: "demo2_13") ]
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeLabel.isHidden = true
        self.title = "Room " + String(room.roomID)
        changeButtons()
        
        //Set dirt_heatmap
        //let convertedHeatMap = self.base64Convert(base64String: room.dirtHeatmap)
        //self.heatMapImageView.image = convertedHeatMap
        
        //for demo
        self.heatMapImageView.image = UIImage.init(named: "demo2_1")
 
    }
    
    // Timer calls this every second
    @objc func countTime() {
        time += 1
        timeLabel.text = String(time)
        //print(time)
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
                       case .failure(let error) : print(error)
                       }})
               
                 } catch {
                     print("Error getting data from API")
                 }
          
       }
    
    
    //timerForRequest calls this every 10 seconds, for the demo version
    @objc func change_image() {
        
        if (imagesArray.count == counter)
        {
            timerForRequest.invalidate()
             counter = 0
         } else {
        
        self.heatMapImageView.image = imagesArray[counter]
          
        counter += 1
            print (counter)
        }
       }
    
    // Changes start and stop cleaning buttons. Disables back navigation for timer to work correctly
    func changeButtons() {
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
    
    //MARK: Actions
    @IBOutlet weak var startButton: RoundButton!
    @IBAction func startButtonClicked(_ sender: UIButton) {
        isCleaning = true
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(countTime), userInfo: nil, repeats: true)
        changeButtons()
        //when "Start" button is pressed we should see mov_heatmap
        //let convertedMov_heatmap = self.base64Convert(base64String: room.movHeatmap)
        //self.heatMapImageView.image = convertedMov_heatmap
        
        //for demo version
        self.heatMapImageView.image = UIImage.init(named: "demo2_1")
        
        
        //update mov_heatmap every 10 seconds
        timerForRequest = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(change_image), userInfo: nil, repeats: true)
      }
    
    @IBAction func cleanedButtonClicked(_ sender: UIButton) {
        isCleaning = false
        timer.invalidate()
        //stop to update mov_heatmap
        timerForRequest.invalidate()
        print("Timer stopped")
        changeButtons()
        self.performSegue(withIdentifier: "showReport", sender: "cleanedButton")
    }
    
    @IBAction func scheduleButtonClicked(_ sender: UIButton) {
      
    }
    
    // Converts heatmap data to images
    func base64Convert(base64String: String?) -> UIImage{
      if (base64String?.isEmpty)! {
          return #imageLiteral(resourceName: "no_image_found")
      }else {
          // !!! Separation part is optional, depends on your Base64String !!!
          let temp = base64String
          let dataDecoded : Data = Data(base64Encoded: temp!, options: .ignoreUnknownCharacters)!
          let decodedimage = UIImage(data: dataDecoded)
          return decodedimage!
      }
    }
}
