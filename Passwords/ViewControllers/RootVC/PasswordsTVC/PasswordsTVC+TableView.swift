//
//  PasswordsTVC+TableView.swift
//  Passwords
//
//  Created by Eugene G on 9/9/21.
//

import UIKit

extension PasswordsTVC {
    
    // MARK: - TableView data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isFiltering() {
            return self.passwordViewModelParent.filteredPasswordViewModels.count
        } else {
            if (self.passwordViewModelParent.passwordViewModels.count == 0){
                self.tableView.setEmptyState("No passwords yet", "Please create passord to display it here")
            } else {
                self.tableView.restore()
            }
            return self.passwordViewModelParent.passwordViewModels.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let passCell = tableView.dequeueReusableCell(withIdentifier: "passCell", for: indexPath) as? PasswordCell else {
            print("Error in list item cell")
            return UITableViewCell()
        }
        if self.isFiltering() {
            passCell.passwordViewModel = self.passwordViewModelParent.filteredPasswordViewModels[indexPath.row]
        } else {
            passCell.passwordViewModel = self.passwordViewModelParent.passwordViewModels[indexPath.row]
        }
        return passCell
    }
    
    
    // MARK: - TableView delegate
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if !self.isFiltering() {
            if editingStyle == .delete {
                let selPass = self.passwordViewModelParent.passwordViewModels[indexPath.row]
                let alert = UIAlertController(
                    title: "Are you sure?",
                    message: "Are you sure you want to delete \(selPass.title)?",
                    preferredStyle: .alert)
                
                let yesButton = UIAlertAction(title: "yes", style: .default) { (action) in
                    DataManager.shared.cacheDeletePassword(id: selPass.getID()) { success in
                        if success {
                            self.passwordViewModelParent.deletePasswordViewModel(index: indexPath.row)
                            tableView.deleteRows(at: [indexPath], with: .fade)
                        } else {
                            self.showAlert(title: "Error", message: "Error deleting password")
                        }
                    }
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
            let selPass = self.passwordViewModelParent.filteredPasswordViewModels[indexPath.row]
            print("🔑SELECTED FILTERED Password: \(selPass)")
        } else {
            let selPass = self.passwordViewModelParent.passwordViewModels[indexPath.row]
            print("🔑SELECTED Password: \(selPass)")
        }
    }

    
}
