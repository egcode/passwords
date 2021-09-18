//
//  LoginTVC+TableView.swift
//  Passwords
//
//  Created by Eugene G on 9/17/21.
//

import UIKit

extension LoginTVC {
    
    // MARK: - TableView data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isFiltering() {
            return self.filteredUsers.count
        } else {
            if (self.users.count == 0){
                self.tableView.setEmptyState("No collections yet", "Please create collection to display it here")
            } else {
                self.tableView.restore()
            }
            return self.users.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let loginCell = tableView.dequeueReusableCell(withIdentifier: "logCell", for: indexPath) as? LoginCell else {
            Log.debug("Error in LoginCell")
            return UITableViewCell()
        }
        if self.isFiltering() {
            loginCell.configureCell(user: self.filteredUsers[indexPath.row])
        } else {
            loginCell.configureCell(user: self.users[indexPath.row])
        }
        return loginCell
    }
    
    
    // MARK: - TableView delegate
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if !self.isFiltering() {
            if editingStyle == .delete {
                let selUser = self.users[indexPath.row]
                let alert = UIAlertController(
                    title: "Are you sure?",
                    message: "Are you sure you want to delete \(selUser.name)?",
                    preferredStyle: .alert)
                
                let yesButton = UIAlertAction(title: "yes", style: .default) { (action) in
                    DataManager.shared.cacheDeleteUser(user: selUser)
                    self.users.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .fade)
                }
                let noButton = UIAlertAction(title: "no", style: .default) { (action) in
                    //
                }
                alert.addAction(noButton)
                alert.addAction(yesButton)
                self.present(alert, animated: true, completion: nil)
            }
        }
            

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.isFiltering() {
            let selUser = self.filteredUsers[indexPath.row]
            self.handleSelect(user: selUser)
        } else {
            let selUser = self.users[indexPath.row]
            self.handleSelect(user: selUser)
        }
    }

    // MARK: - Handle Did select
    
    func handleSelect(user: User) {
        Log.debug("🔑SELECTED user: \(user.name)")
    }
    
}
