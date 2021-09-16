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
            DataManager.shared.cacheGetUsePassword { usePassword in
                self.switchOnOff.isOn = usePassword
            }
            break
        case .touchFaceID:
            DataManager.shared.cacheGetUsePassword { usePassword in
                self.switchOnOff.isEnabled = usePassword
                self.labelTitle.isEnabled = usePassword
                DataManager.shared.cacheGetUseTouchFaceID { useTouchFaceID in
                    self.switchOnOff.isOn = useTouchFaceID
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
