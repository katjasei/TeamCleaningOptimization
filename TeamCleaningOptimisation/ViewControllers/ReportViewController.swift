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
    var success = true
    var freeComment = ""
    var pdComment = ""
    var commentToBeSent = ""
    
    @IBOutlet weak var rCleanerTF:      UITextField!
    @IBOutlet weak var rCleanIndTF:     UITextField!
    @IBOutlet weak var rSuccessTF:      UITextField!
    @IBOutlet weak var rCommentPicker:  UITextField!
    @IBOutlet weak var resultHeatmapImage: UIImageView!
    @IBOutlet weak var freeCommentTextField: UITextField!
    
    let pdCommentOptions = ["Room locked",
                   "Room occupied",
                   "Room with infection"]
    let successOptions = ["Yes", "No"]
    
    var selectedPdCommentOption: String?
    var selectedSuccessOption = "Yes"
    
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
    
    // Free comment is sent if both exist
    func decideComment() {
        if pdComment != "" {
            commentToBeSent = pdComment
        }
        if freeComment != "" {
            commentToBeSent = freeComment
        }
    }
    
    func decideSuccess() {
        if selectedSuccessOption != "Yes" {
            success = false
        }
    }
    
    func createPdCommentOptionPicker() {
        
        let pdCommentOptionPicker = UIPickerView()
        pdCommentOptionPicker.delegate = self
        pdCommentOptionPicker.backgroundColor = .white
        pdCommentOptionPicker.restorationIdentifier = "pd"
        rCommentPicker.inputView = pdCommentOptionPicker
    }
    
    func createSuccessOptionPicker() {
        
        let successOptionPicker = UIPickerView()
        successOptionPicker.delegate = self
        successOptionPicker.restorationIdentifier = "success"
        rSuccessTF.inputView = successOptionPicker
    }
    
    func createToolBar() {
        
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

