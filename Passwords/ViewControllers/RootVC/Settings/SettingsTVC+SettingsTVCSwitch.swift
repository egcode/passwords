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
                        s.showSettingsPasswordEditAlert(title: "Disabling Password", message: "Please enter your current password", currentPassword: sp.userPassword) { match, error in
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
    
}
