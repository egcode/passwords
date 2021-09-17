//
//  SettingsTVC+SettingsTVCSwitch.swift
//  Passwords
//
//  Created by Eugene G on 9/15/21.
//

import UIKit

protocol SettingsTVCSwitch: AnyObject {
    func switchDidChange(cellType: SettingsTVC.CellType, isOn: Bool)
}

extension SettingsTVC : SettingsTVCSwitch {
    func switchDidChange(cellType: CellType, isOn: Bool) {
        switch cellType {
        case .passwordEnable:
            if isOn {
                // Create new
                let setPassCreateVC = SettingsCreateEditPasswordVC.initFromStoryboard(settingsPassword: nil, delegate: self)
                let pcNC = UINavigationController(rootViewController: setPassCreateVC)
                self.present(pcNC, animated: true) {
                    self.refreshTableView(animated: false)
                }
            } else {
                
                DataManager.shared.cacheGetSettingsPassword { [weak self] setPass in
                    if let sp = setPass, let s = self {
//                        sp.userPassword
                        s.showPasswordChangeAlert(currentPassword: sp.userPassword) { match, error in
                            if match && error == nil {
                                
                                // Delete Existing one
                                DataManager.shared.cacheDeleteSettingsPassword { success in
                                    if success {
                                        s.refreshTableView(animated: true)
                                    } else {
                                        s.showAlert(title: "Error deleting settings password", message: "") {
                                            s.refreshTableView(animated: true)
                                        }
                                    }
                                }
                                
                                
                            } else if let e=error {
                                s.showAlert(title: e, message: "") {
                                    s.refreshTableView(animated: true)
                                }
                            }
                        }
                    } else {
                        Log.error("⛔️ Error getting settings password")
                    }
                }
            }
            break
        case .touchFaceID:
            DataManager.shared.cacheGetSettingsPassword { [weak self] setPass in
                if let sp = setPass, let s = self {
                    DataManager.shared.cacheUpdateSettingsPasswordUseTouchID(settingPasswordID: sp.id, useTouchFaceID: isOn) { success in
                        if !success {
                            s.showAlert(title: "Unable to enable/disable Touch/Face ID", message: "") {
                                s.refreshTableView(animated: true)
                            }
                        }
                    }
                } else {
                    Log.error("⛔️ Error getting settings password")
                }
            }
            break
        default:
            Log.error("⛔️ Weird switch triggered")
        }
    }
    
    fileprivate func showPasswordChangeAlert(currentPassword: String, completion: @escaping (_ match: Bool, _ error: String?) -> Void) {
        let alert = UIAlertController(title: "Disabling Password", message: "Please enter your current password", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Password"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak self] action in
            self?.refreshTableView(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak alert] (_) in
        if let al = alert, let tfs = al.textFields, let tf = tfs.first {
            if tf.text == currentPassword {
                completion(true, nil)
            } else {
                completion(false, "Wrong password")
            }
        } else {
            completion(false, "Internal error")
        }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
