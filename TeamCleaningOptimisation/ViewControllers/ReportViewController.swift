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
    private var cleaner  = UserName.shared.userName
    var time     = 0
    private var cleanInd = "95"
    private var success = true
    private var freeComment = ""
    private var pdComment = ""
    private var commentToBeSent = ""
    private let pdCommentOptions = ["Room locked",
                   "Room occupied",
                   "Room with infection"]
    private let successOptions = ["Yes", "No"]
    
    private var selectedPdCommentOption: String?
    private var selectedSuccessOption = "Yes"
    
    @IBOutlet weak var rCleanerTF:      UITextField!
    @IBOutlet weak var rCleanIndTF:     UITextField!
    @IBOutlet weak var rSuccessTF:      UITextField!
    @IBOutlet weak var rCommentPicker:  UITextField!
    @IBOutlet weak var resultHeatmapImage: UIImageView!
    @IBOutlet weak var freeCommentTextField: UITextField!
    @IBAction func onClickSendReport(_ sender: RoundButton) {
        postReport()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createPdCommentOptionPicker()
        createToolBar()
        createSuccessOptionPicker()
        
        self.title = "Report \(roomNumb)"
        
        rCleanerTF.text  = cleaner
        rCleanIndTF.text = cleanInd
        rSuccessTF.text = "Yes"
        
        //for demo
        self.resultHeatmapImage.image = UIImage.init(named: "demo2_13")
    }
    
    private func postReport() {
        // Set reportID to a random int 0-100 000
        let reportID = String(Int.random(in: 0...100000))
        
        // Set free comment
        freeComment = freeCommentTextField.text ?? ""
        
        // Set predetermined comment
        pdComment = rCommentPicker.text ?? ""
        decideComment()
        decideSuccess()
        
        let apiRequest = APIRequest()
        let report = Report(reportID: reportID, forRoomID: roomNumb, cleanerName: cleaner, wasCleaningSuccessful: success, cleanerComments: commentToBeSent)
        
        do {
            try apiRequest.postReport(report: report)
        } catch {
            print("Error posting report to API (from reportVC)")
        }
    }
    
    // Free comment is sent if both exist
    private func decideComment() {
        if pdComment != "" {
            commentToBeSent = pdComment
        }
        if freeComment != "" {
            commentToBeSent = freeComment
        }
    }
    
    private func decideSuccess() {
        if selectedSuccessOption != "Yes" {
            success = false
        }
    }
    
    private func createPdCommentOptionPicker() {
        
        let pdCommentOptionPicker = UIPickerView()
        pdCommentOptionPicker.delegate = self
        pdCommentOptionPicker.backgroundColor = .white
        pdCommentOptionPicker.restorationIdentifier = "pd"
        rCommentPicker.inputView = pdCommentOptionPicker
    }
    
    private func createSuccessOptionPicker() {
        
        let successOptionPicker = UIPickerView()
        successOptionPicker.delegate = self
        successOptionPicker.restorationIdentifier = "success"
        rSuccessTF.inputView = successOptionPicker
    }
    
    private func createToolBar() {
        
        let toolbar = UIToolbar()
        
        rCommentPicker.hideSuggestions()
        rSuccessTF.hideSuggestions()
        toolbar.barStyle = UIBarStyle.default
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissKeyboard))
        
        toolbar.setItems([doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        
        rCommentPicker.inputAccessoryView = toolbar
        rSuccessTF.inputAccessoryView = toolbar
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
        switch pickerView.restorationIdentifier {
        case "success":
            return successOptions.count
        case "pd":
            return pdCommentOptions.count
        default:
            return pdCommentOptions.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.restorationIdentifier {
        case "success":
            return successOptions[row]
        case "pd":
            return pdCommentOptions[row]
        default:
            return pdCommentOptions[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerView.restorationIdentifier {
        case "success":
            selectedSuccessOption = successOptions[row]
            rSuccessTF.text = selectedSuccessOption
        case "pd":
            selectedPdCommentOption = pdCommentOptions[row]
            rCommentPicker.text = selectedPdCommentOption
        default:
            selectedPdCommentOption = pdCommentOptions[row]
            rCommentPicker.text = selectedPdCommentOption
            
        }
    }
}


