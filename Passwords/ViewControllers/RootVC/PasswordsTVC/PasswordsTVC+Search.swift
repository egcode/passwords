//
//  PasswordsTVC+Search.swift
//  Passwords
//
//  Created by Eugene G on 9/9/21.
//

import UIKit

extension PasswordsTVC {
    
    override func filterContentForSearchText(_ searchText: String) {
                
        guard let searchTextRaw = searchController.searchBar.text else {
            print("search bar is empty, ignoring...")
            return
        }
        self.passwordViewModelParent.filteredPasswordViewModels.removeAll()
        
        let searchText = searchTextRaw.trimmingCharacters(in: .whitespaces)
        if searchText.count < 2 {
            self.refreshTableView()
            return
        }
        
        self.passwordViewModelParent.filteredPasswordViewModels = self.passwordViewModelParent.passwordViewModels.filter({ (password) -> Bool in
            return password.title.lowercased().contains(searchText.lowercased())
        })
        
        self.refreshTableView()
    }
    
}
