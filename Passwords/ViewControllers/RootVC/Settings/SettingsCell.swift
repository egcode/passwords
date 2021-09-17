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
            }
            break
        default:
            break
        }
    }

}
