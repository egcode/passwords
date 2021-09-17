//
//  SettingsCell.swift
//  Passwords
//
//  Created by Eugene G on 9/15/21.
//

import UIKit

class SettingsCell: UITableViewCell {
    @IBOutlet weak var labelTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(title: String, type: SettingsTVC.CellType) {
        self.labelTitle.text = title
        
        switch type {
        case .passwordChange:
            DataManager.shared.cacheGetSettingsPassword { settingsPassword in
                self.labelTitle.isEnabled = (settingsPassword != nil)
                if settingsPassword == nil {
                    self.selectionStyle = UITableViewCell.SelectionStyle.none
                } else {
                    self.selectionStyle = UITableViewCell.SelectionStyle.default
                }
            }
            break
        default:
            break
        }
    }

}
