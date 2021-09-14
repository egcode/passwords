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
    
    weak var delegate: PasswordsTVCRefreshProtocol?
    
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
        
        // UITextFieldDelegate setup
        self.textFieldTitle.delegate = self
        self.textFieldUserID.delegate = self
        self.textFieldPassword.delegate = self
        self.textFieldDescription.delegate = self
        
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
        self.submit()
    }
    
    
    // MARK: - Submit
    
    func submit() {
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
        DataManager.shared.cacheSavePassword(title: title, password: password, userID: userID, desc: desc) {[weak self] passwordObject in
            if let pass = passwordObject {
                DataManager.shared.addPassword(password: pass)
                self?.delegate?.addPassword(passwordVM: PasswordViewModel(password: pass))
                self?.dismiss(animated: true, completion: nil)
            } else {
                self?.showAlert(title: "Cache error", message: "Unable to save password", completion: {
                    self?.dismiss(animated: true, completion: nil)
                })
            }
        }
    }
    
}
