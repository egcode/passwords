//
//  LoginVC.swift
//  Passwords
//
//  Created by Eugene G on 9/8/21.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var textFieldPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func onSubmit(_ sender: UIButton) {
        StartupVC.showRootVC()
    }
    
}
