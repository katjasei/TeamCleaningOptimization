//
//  ReportViewController.swift
//  TeamCleaningOptimization
//
//  Created by Artur Kulagin on 1.4.2020.
//  Copyright © 2020 TeamCleaningOptimization. All rights reserved.
//

import UIKit

class ReportViewController: UIViewController {
    
    var roomNumb = String()
    var cleaner  = "Leonardo DiCpario"
    var time     = 0
    var cleanInd = "95"
    var success  = "Yes"
    
    @IBOutlet weak var rCleanerTF:  UITextField!
    @IBOutlet weak var rTimeTF:     UITextField!
    @IBOutlet weak var rCleanIndTF: UITextField!
    @IBOutlet weak var rSuccessTF:  UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Report \(roomNumb)"
        
        rCleanerTF.text  = cleaner
        rTimeTF.text     = String(time)
        rCleanIndTF.text = cleanInd
        rSuccessTF.text  = success
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if segue.identifier == "ShowRoomInfo" {
               let destinationViewController = segue.destination as! RoomInfoViewController
               destinationViewController.getNumber = self.roomNumb
           }
       }*/
    
}
