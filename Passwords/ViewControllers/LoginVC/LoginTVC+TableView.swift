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
        var usrs = self.users
        if self.isFiltering() {
            usrs = self.filteredUsers
        }
        if indexPath.row == 0 {
            if usrs.count == 1 {
                loginCell.configureCell(user: usrs[indexPath.row], top: true, bottom: true)
            } else {
                loginCell.configureCell(user: usrs[indexPath.row], top: true, bottom: false)
            }
        } else if indexPath.row == usrs.count-1 {
            loginCell.configureCell(user: usrs[indexPath.row], top: false, bottom: true)
        } else {
            loginCell.configureCell(user: usrs[indexPath.row], top: false, bottom: false)
        }
        return loginCell
    }
    
    
    // MARK: - TableView delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return LoginCell.cellHeight
    }
    
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
        self.tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Handle Did select
    
    func handleSelect(user: User) {
        Log.debug("🔑SELECTED user: \(user.name)")
        DataManager.shared.userID = user.id
        
        if let settingsPass = user.settingsPassword {
            if settingsPass.useTouchFaceID {
                
                // -- Touch/Face ID Login
                Log.debug("🆔 Using Touch ID")
                
                var isBiometricNeeded = true
                #if targetEnvironment(simulator)
                isBiometricNeeded = false
                #else
                #endif
                if Passcode.isDevicePasscodeSet() && isBiometricNeeded {
                    Passcode.authenticateUser(message: "Please authenticate to proceed") { (success, error) in
                        if success && error == nil {
                            Log.debug("🔑 Login with touch/face ID")
                            StartupVC.showRootVC()
                        } else {
                            if let e = error {
                                self.showAlert(title: "Error", message: e.localizedDescription)
                            } else {
                                self.showAlert(title: "Error", message: "Something went wrong")
                            }
                        }
                    }
                } else {
                    Log.debug("🔑 Login without credentials, passcode is not set, or it is simulator")
                    StartupVC.showRootVC()
                }
            } else {
                // -- Password Login
                Log.debug("🆔 Using Password")
                
                let alert = UIAlertController(title: "Enter Password", message: "Please enter password to use this collection", preferredStyle: .alert)
                alert.addTextField { (textField) in
                    textField.placeholder = "Password"
                }
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak self] action in
                    self?.refreshTableView(animated: true)
                }))
                alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak alert] (_) in
                if let al = alert, let tfs = al.textFields, let tf = tfs.first {
                    if tf.text == settingsPass.userPassword {
                        Log.debug("🔑 Login with Password")
                        StartupVC.showRootVC()
                        
                    } else {
                        self.showAlert(title: "Wrong password", message: "")
                    }
                } else {
                    self.showAlert(title: "Internal errow", message: "")
                }
                }))
                self.present(alert, animated: true, completion: nil)
                
            }
        } else {
            Log.debug("🔑 Login without credentials")
            StartupVC.showRootVC()
        }

    }
    
}
