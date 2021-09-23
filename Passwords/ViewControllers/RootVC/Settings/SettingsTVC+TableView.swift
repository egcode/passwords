//
//  SettingsTVC+TableView.swift
//  Passwords
//
//  Created by Eugene G on 9/15/21.
//

import UIKit

protocol SettingsTVCRefresh: AnyObject {
    func refreshFromDelegate()
}

extension SettingsTVC: SettingsTVCRefresh {
    func refreshFromDelegate() {
        self.refreshTableView(animated: true)
    }
}

extension SettingsTVC {
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sect.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sect[section].title
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sect[section].cells.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let c = self.sect[indexPath.section].cells[indexPath.row]
        if c.type == .passwordEnable || c.type == .touchFaceID {
            guard let settingCellSwitch = tableView.dequeueReusableCell(withIdentifier: "SettingsCellSwitch", for: indexPath) as? SettingsCellSwitch else {
                Log.error("⛔️ Unable to initialise SettingsCellSwitch")
                return UITableViewCell()
            }
            settingCellSwitch.configureCell(title: c.title, type: c.type, delegate: self)
            return settingCellSwitch
        } else {
            guard let settingCell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as? SettingsCell else {
                Log.error("⛔️ Unable to initialise SettingsCell")
                return UITableViewCell()
            }
            settingCell.configureCell(title: c.title, type: c.type)
            return settingCell
        }
    }
    
    
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let c = self.sect[indexPath.section].cells[indexPath.row]
        
        switch c.type {
        case .passwordChange:
            // Ignore tap if there is no password
            if c.type == .passwordChange {
                DataManager.shared.cacheGetSettingsPassword { settingsPassword in
                    if settingsPassword == nil {
                        return
                    } else {
                        if let action = c.action {
                            action()
                        }
                    }
                }
            }
            
            break
        default:
            c.action?()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)

    }

}
