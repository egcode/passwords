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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.switchOnOff.onTintColor = Colors.mainColor
    }
    
    @IBAction func actionSwitch(_ sender: UISwitch) {
        
    }
    
}
