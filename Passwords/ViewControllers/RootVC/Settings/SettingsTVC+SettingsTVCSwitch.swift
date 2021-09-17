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
                // Delete Existing one
                DataManager.shared.cacheDeleteSettingsPassword { success in
                    if success {
                        self.refreshTableView(animated: true)
                    } else {
                        self.showAlert(title: "Error deleting settings password", message: "", completion: nil)
                    }
                }
            }
            
//            DataManager.shared.cacheGetUsePassword { currentUsePassword in
//                if currentUsePassword == false {
//                    // Create new password
//                    // SettingsPasswordCreateEditVC here
//
//                } else {
//                    // Use current password to remove it
//                    // Alert with current password here
//
//                }
//            }
            
            
            

//            DataManager.shared.cacheSetUsePassword(isOn: isOn) { isOnSet in
//                Log.debug("PasswordEnable Switch changed to \(isOnSet)")
//            }
//
//
//            self.refreshTableView(animated: true)
            break
        case .touchFaceID:
            
//            DataManager.shared.cacheSetUseTouchFaceID(isOn: isOn) { isOnSet in
//                Log.debug("TouchFaceID Switch changed to \(isOnSet)")
//            }
            
            break
        default:
            Log.error("⛔️ Weird switch triggered")
        }
    }
    
    
}
