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
            DataManager.shared.cacheSetUsePassword(isOn: isOn) { isOnSet in
                Log.debug("PasswordEnable Switch changed to \(isOnSet)")
            }
            self.refreshTableView(animated: true)
            break
        case .touchFaceID:
            DataManager.shared.cacheSetUseTouchFaceID(isOn: isOn) { isOnSet in
                Log.debug("TouchFaceID Switch changed to \(isOnSet)")
            }
            break
        default:
            Log.error("⛔️ Weird switch triggered")
        }
    }
    
    
}
