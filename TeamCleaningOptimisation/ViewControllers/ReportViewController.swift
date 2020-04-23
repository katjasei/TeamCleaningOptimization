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
    var cleaner  = "Leonardo DiCaprio"
    var time     = 0
    var cleanInd = "95"
    var success  = "Yes"
    
    @IBOutlet weak var rCleanerTF:      UITextField!
    @IBOutlet weak var rCleanIndTF:     UITextField!
    @IBOutlet weak var rSuccessTF:      UITextField!
    @IBOutlet weak var rCommentPicker:  UITextField!
    @IBOutlet weak var resultHeatmapImage: UIImageView!
    @IBAction func onClickSendReport(_ sender: RoundButton) {
        postReport()
    }
    
    let options = ["Room locked",
                   "Room occupied",
                   "Room with infection"]
    
    var selectedOption: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createOptionPicker()
        createToolBar()
        
        self.title = "Report \(roomNumb)"
        
        rCleanerTF.text  = cleaner
        rCleanIndTF.text = cleanInd
        rSuccessTF.text  = success
        
        //for demo
        self.resultHeatmapImage.image = UIImage.init(named: "demo2_13")
    }
    
    func postReport() {
        // Dummy data for post testing
        let timeOfCleaning = "01:00"
        let reportID = "2"
        let wasCleaningSuccessful: Bool = true
        let cleanerComments = "Everything went well"
        
        let apiRequest = APIRequest()
        let report = Report(reportID: reportID, forRoomID: roomNumb, cleanerName: cleaner, timeOfCleaning: timeOfCleaning, wasCleaningSuccessful: wasCleaningSuccessful, cleanerComments: cleanerComments)
        do{
            try apiRequest.postReport(report: report)
        } catch {
            print("Error posting report to API (from reportVC)")
        }
    }
    
    func createOptionPicker() {
        
        let optionPicker = UIPickerView()
        optionPicker.delegate = self
        optionPicker.backgroundColor = .white
        rCommentPicker.inputView = optionPicker
    }
    
    func createToolBar() {
        
        let toolbar = UIToolbar()
        
        rCommentPicker.hideSuggestions()
        toolbar.barStyle = UIBarStyle.default
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissKeyboard))
        
        toolbar.setItems([doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        
        rCommentPicker.inputAccessoryView = toolbar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension ReportViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return options[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedOption = options[row]
        rCommentPicker.text = selectedOption
        
    }
}


extension UITextView {
    func hideSuggestions() {
        // Removes suggestions only
        autocorrectionType = .no
        //Removes Undo, Redo, Copy & Paste options
        removeUndoRedoOptions()
    }
}

extension UITextField {
    func hideSuggestions() {
        // Removes suggestions only
        autocorrectionType = .no
        //Removes Undo, Redo, Copy & Paste options
        removeUndoRedoOptions()
    }
}

extension UIResponder {
    func removeUndoRedoOptions() {
        //Removes Undo, Redo, Copy & Paste options
        inputAssistantItem.leadingBarButtonGroups = []
        inputAssistantItem.trailingBarButtonGroups = []
    }
}
