//
//  SettingsTVC+TableView.swift
//  Passwords
//
//  Created by Eugene G on 9/15/21.
//

import UIKit

extension SettingsTVC {
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sect.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sect[section].title
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sect[section].processTypes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let settingCellSwitch = tableView.dequeueReusableCell(withIdentifier: "SettingsCellSwitch", for: indexPath) as? SettingsCellSwitch else {
                Log.error("⛔️ Unable to initialise SettingsCellSwitch")
                return UITableViewCell()
            }
            //disable cell clicking
            settingCellSwitch.selectionStyle = UITableViewCell.SelectionStyle.none
            settingCellSwitch.labelTitle?.text = self.sect[indexPath.section].processTypes[indexPath.row]
            return settingCellSwitch
        } else if indexPath.section == 1 {
            guard let settingCell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as? SettingsCell else {
                Log.error("⛔️ Unable to initialise SettingsCell")
                return UITableViewCell()
            }
            settingCell.labelTitle?.text = self.sect[indexPath.section].processTypes[indexPath.row]
            return settingCell
        }
        return UITableViewCell()
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        if indexPath.section == 0 {
            switch indexPath.row {
                case 0:
                    Log.debug("Password Protection")
                    break
                case 1:
                    Log.debug("Touch/Face ID")
                    break
                default:
                    Log.debug("Nothing Selected")
                    break
            }
        } else if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                Log.debug("Export Passwords")
                break
            default:
                Log.debug("Nothing Selected")
                break
            }
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

}
