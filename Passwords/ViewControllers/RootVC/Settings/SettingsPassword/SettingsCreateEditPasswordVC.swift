//
//  SettingsCreateEditPasswordVC.swift
//  Passwords
//
//  Created by Eugene G on 9/16/21.
//

import UIKit

class SettingsCreateEditPasswordVC : UIViewController {
    
    @IBOutlet weak var textFieldNewPassword: UITextField!
    @IBOutlet weak var textFieldRepeatPassword: UITextField!
    @IBOutlet weak var textFieldYourQuestion: UITextField!
    @IBOutlet weak var textFieldYourAnswer: UITextField!
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var buttonSubmit: UIButton!

    private var settingsPassword: SettingsPassword?
    var delegate: SettingsTVCRefresh!
    
    // MARK: - init/deinit
    
    public static func initFromStoryboard(settingsPassword: SettingsPassword?, delegate: SettingsTVCRefresh) -> SettingsCreateEditPasswordVC {
        let sb = UIStoryboard(name: "RootVC", bundle: Bundle(for: SettingsCreateEditPasswordVC.self))
        guard let settingsPasswordCreateVC = sb.instantiateViewController(withIdentifier: "SettingsCreateEditPasswordVCID") as? SettingsCreateEditPasswordVC else {
            Log.debug("⛔️ Error getting SettingsCreateEditPasswordVCID from storyboard")
            return SettingsCreateEditPasswordVC()
        }
        settingsPasswordCreateVC.delegate = delegate
        settingsPasswordCreateVC.settingsPassword = settingsPassword
        return settingsPasswordCreateVC
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        Log.error("SettingsCreateEditPasswordVC inited without storyboard. It should not happen")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Log.debug("SettingsCreateEditPasswordVC inited")
    }

    deinit {
        Log.debug("SettingsCreateEditPasswordVC deinited")
    }

    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // UITextFieldDelegate setup
        self.textFieldNewPassword.delegate = self
        self.textFieldRepeatPassword.delegate = self
        self.textFieldYourQuestion.delegate = self
        self.textFieldYourAnswer.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // ✏️ Edit Mode
        if let settPass = self.settingsPassword {
            self.textFieldYourQuestion.text = settPass.userSecurityQuestion
            self.textFieldYourAnswer.text = settPass.userSecurityAnswer
        }
        self.textFieldNewPassword.becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    
    
    // MARK: - Actions
    
    @IBAction func actionButtonCancel(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.delegate.refreshFromDelegate()
        }
    }
    
    @IBAction func actionButtonSubmit(_ sender: UIButton) {
        self.submit()
    }

    
    // MARK: - Submit
    
    func submit() {
        var newPassword = ""
        var newPasswordRepeat = ""
        var yourQuestion = ""
        var yourAnswer = ""
        
        if let np = self.textFieldNewPassword.text {
            newPassword = np
        }
        if let npr = self.textFieldRepeatPassword.text {
            newPasswordRepeat = npr
        }
        if let yq = self.textFieldYourQuestion.text {
            yourQuestion = yq
        }
        if let ya = self.textFieldYourAnswer.text {
            yourAnswer = ya
        }

        if newPassword != newPasswordRepeat {
            self.showAlert(title: "Password fields should match", message: "")
            return
        }
        
        if newPassword == "" || newPasswordRepeat == "" || yourQuestion == "" || yourAnswer == ""{
            self.showAlert(title: "Please fill all fields", message: "")
            return
        }
        
        if let settPass = self.settingsPassword {
            // ✏️ Edit Mode
            DataManager.shared.cacheUpdateSettingsPassword(id: settPass.id, newPassword: newPassword, yourQuestion: yourQuestion, yourAnswer: yourAnswer) { [weak self] updatedSetPass in
                if let _ = updatedSetPass {
                    self?.dismiss(animated: true) {
                        self?.delegate.refreshFromDelegate()
                    }
                } else {
                    self?.showAlert(title: "Cache error", message: "Error updating settigns password", completion: {
                        self?.dismiss(animated: true) {
                            self?.delegate.refreshFromDelegate()
                        }
                    })
                }
            }
        } else {
            // 🆕 Create Mode
            DataManager.shared.cacheSaveSettingsPassword(newPassword: newPassword, yourQuestion: yourQuestion, yourAnswer: yourAnswer) { [weak self] success in
                if success {
                    self?.dismiss(animated: true) {
                        self?.delegate.refreshFromDelegate()
                    }
                }  else {
                    self?.showAlert(title: "Cache error", message: "Unable to save new password", completion: {
                        self?.dismiss(animated: true) {
                            self?.delegate.refreshFromDelegate()
                        }
                    })
                }
            }
            
        }

    }
    
    
}
