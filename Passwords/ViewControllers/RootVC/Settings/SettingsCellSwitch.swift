//
//  SettingsCellSwitch.swift
//  Passwords
//
//  Created by Eugene G on 9/15/21.
//

import UIKit

class SettingsCellSwitch: UITableViewCell {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var switchOnOff: UISwitch!
    
    var type: SettingsTVC.CellType = .none
    weak var delegate: SettingsTVCSwitch?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.switchOnOff.onTintColor = Colors.mainColor
    }
    
    func configureCell(title: String, type: SettingsTVC.CellType, delegate: SettingsTVCSwitch) {
        self.labelTitle.text = title
        self.type = type
        self.delegate = delegate
        
        switch type {
        case .passwordEnable:
            DataManager.shared.cacheGetSettingsPassword { settingsPassword in
                self.switchOnOff.isOn = (settingsPassword != nil)
            }
            break
        case .touchFaceID:
            DataManager.shared.cacheGetSettingsPassword { settingsPassword in
                self.switchOnOff.isEnabled = (settingsPassword != nil)
                self.labelTitle.isEnabled = (settingsPassword != nil)
                if let sp = settingsPassword {
                    self.switchOnOff.isOn = sp.useTouchFaceID
                } else {
                    self.switchOnOff.isOn = false
                }
            }
            break
        default:
            break
        }
        
    }
    
    @IBAction func actionSwitch(_ sender: UISwitch) {
        self.delegate?.switchDidChange(cellType: self.type, isOn: sender.isOn)
    }
    
}
