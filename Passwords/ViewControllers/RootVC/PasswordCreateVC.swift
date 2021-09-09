//
//  PasswordCreateVC.swift
//  Passwords
//
//  Created by Eugene G on 9/8/21.
//

import UIKit

class PasswordCreateVC : UIViewController {
    
    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var textFieldUserID: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldDescription: UITextField!
    
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var buttonCreate: UIButton!
    
    // MARK: - init/deinit
    
    @objc public static func initFromStoryboard() -> PasswordCreateVC {
        let sb = UIStoryboard(name: "RootVC", bundle: Bundle(for: PasswordCreateVC.self))
        guard let passwordCreateVC = sb.instantiateViewController(withIdentifier: "PasswordCreateVCID") as? PasswordCreateVC else {
            print("⛔️ Error getting PasswordCreateVCID from storyboard")
            return PasswordCreateVC()
        }
        return passwordCreateVC
    }
    
    deinit {
        print("PasswordCreateVC deinited")
    }

    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation bar Button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(self.actionNavBarButton(sender:)))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.textFieldTitle.becomeFirstResponder()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Actions
    @objc func actionNavBarButton(sender: UIBarButtonItem) {
        self.dismiss(animated: true) {
        }
    }

    @IBAction func actionButtonCancel(_ sender: UIButton) {
        self.dismiss(animated: true) {
        }
    }
    
    @IBAction func actionButtonCreate(_ sender: UIButton) {
        var title = ""
        var password = ""
        var userID = ""
        var desc = ""
        
        if let t = self.textFieldTitle.text,
           let p = self.textFieldPassword.text {
            title = t
            password = p
            if let uid = self.textFieldUserID.text {
                userID = uid
            }
            if let d = self.textFieldDescription.text {
                desc = d
            }
        }
        if title == "" && password == "" {
            self.showAlert(title: "Title and password should not be empty", message: "")
            return
        }
        
        // Ready to create object
        self.showAlert(title: "Created: ", message: "Title: \(title)\nPassword:\(password)\nUserID:\(userID)\nDescription:\(desc)") {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
}
