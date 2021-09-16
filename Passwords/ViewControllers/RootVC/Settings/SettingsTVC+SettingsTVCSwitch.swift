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
        case .touchFaceID:
            Log.debug("TouchFaceID Switch changed to \(isOn)")
            break
        case .passwordEnable:
            Log.debug("PasswordEnable Switch changed to \(isOn)")
            break
        default:
            Log.error("⛔️ Weird switch triggered")
        }
    }
    
    
}
