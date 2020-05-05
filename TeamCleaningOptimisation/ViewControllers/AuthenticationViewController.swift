//
//  AuthenticationViewController.swift
//  TeamCleaningOptimisation
//
//  Created by Artur Kulagin on 27.4.2020.
//  Copyright © 2020 TeamCleaningOptimization. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    var segueToNav = "segueToNav"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameTextField.placeholder = "Type your user name"
        
    }
    
    // Save username in UserName class
    @IBAction func logInPressed(_ sender: Any) {
        UserName.shared.userName = userNameTextField.text ?? "Cleaner"
    }
}


//  Saving username
class UserName {
    static let shared = UserName()

    private init() {}

    var userName: String = "variable containing the form data"
}
