//
//  PasswordCreateVC.swift
//  Passwords
//
//  Created by Eugene G on 9/8/21.
//

import UIKit

class PasswordCreateEditVC : UIViewController {
    
    @IBOutlet weak var textFieldTitle: UITextField!
    @IBOutlet weak var textFieldUserID: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldDescription: UITextField!
    
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var buttonSubmit: UIButton!
    
    weak var delegate: PasswordsTVCRefreshProtocol?
    weak var passwordViewModel: PasswordViewModel? // If in ✏️ Edit Mode
    var action = {}
    
    // MARK: - init/deinit
    
    @objc public static func initFromStoryboard() -> PasswordCreateEditVC {
        let sb = UIStoryboard(name: "RootVC", bundle: Bundle(for: PasswordCreateEditVC.self))
        guard let passwordCreateVC = sb.instantiateViewController(withIdentifier: "PasswordCreateEditVCID") as? PasswordCreateEditVC else {
            Log.debug("⛔️ Error getting PasswordCreateEditVCID from storyboard")
            return PasswordCreateEditVC()
        }
        return passwordCreateVC
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        Log.error("PasswordCreateEditVC inited without storyboard. It should not happen")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Log.debug("PasswordCreateEditVC inited")
    }

    deinit {
        Log.debug("PasswordCreateEditVC deinited")
    }

    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Remove Large Title
        self.navigationItem.largeTitleDisplayMode = .never
        
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
        
        // ✏️ Edit Mode
        if let passVM = self.passwordViewModel {
            self.textFieldTitle.text = passVM.title
            self.textFieldUserID.text = passVM.userID
            self.textFieldPassword.text = passVM.pass
            self.textFieldDescription.text = passVM.desc
        }
        self.textFieldTitle.becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Actions
    @objc func actionNavBarButton(sender: UIBarButtonItem) {
        self.dismisVC(completion: nil)
    }

    @IBAction func actionButtonCancel(_ sender: UIButton) {
        self.dismisVC(completion: nil)
    }
    
    @IBAction func actionButtonSubmit(_ sender: UIButton) {
        self.submit()
    }
    // MARK: - Dismiss
    
    func dismisVC(completion: (()->())? ) {
        if self.passwordViewModel == nil {
            self.dismiss(animated: true) {
                if let c = completion {
                    c()
                }
            }
        } else {
            // ✏️ Edit Mode
            self.navigationController?.popViewController(animated: true, completion: {
                if let c = completion {
                    c()
                }
            })
        }
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
        
        // ✏️ Edit Mode
        if let passVM = self.passwordViewModel {
            DataManager.shared.cacheUpdatePassword(id: passVM.getID(), title: title, password: password, userID: userID, desc: desc) {[weak self] updatedPassword in
                if let p = updatedPassword {
                    passVM.updatePassword(password: p)
                    self?.dismisVC(completion: {
                        self?.action()
                    })
                } else {
                    self?.showAlert(title: "Cache error", message: "Unable to update password", completion: {
                        self?.dismisVC(completion: nil)
                    })
                }
            }
        } else {
            // 🆕 Create Mode
            // Ready to create object
            DataManager.shared.cacheSavePassword(title: title, password: password, userID: userID, desc: desc) {[weak self] passwordObject in
                if let pass = passwordObject {
                    self?.delegate?.addPassword(passwordVM: PasswordViewModel(password: pass))
                    self?.dismiss(animated: true, completion: nil)
                } else {
                    self?.showAlert(title: "Cache error", message: "Unable to save new password", completion: {
                        self?.dismisVC(completion: nil)
                    })
                }
            }
        }
    }
    
}
