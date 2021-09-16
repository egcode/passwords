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
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
        cell.textLabel?.text = self.sect[indexPath.section].processTypes[indexPath.row]
        return cell
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
                Log.debug("Export Plist")
                break
            case 1:
                Log.debug("Import Plist")
                break
            default:
                Log.debug("Nothing Selected")
                break
            }
        }
    }

}
