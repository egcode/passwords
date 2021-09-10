//
//  BaseTVC+Search.swift
//  Passwords
//
//  Created by Eugene G on 9/9/21.
//

import UIKit

extension BaseTVC  {
    
    func setupSearchBar() {
        // Search Setup
        self.searchController.searchResultsUpdater = self
//        self.searchController.hidesNavigationBarDuringPresentation = false /// causes navigation title overlay bug
        self.definesPresentationContext = true
//        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.searchBar.searchBarStyle = UISearchBar.Style.minimal
        // Search controller cancelButton
        self.searchController.searchBar.setValue("Cancel", forKey:"cancelButtonText")
        
        // Searchbar text Font
        if let textFieldInsideSearchBar = self.searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textFieldInsideSearchBar.font = Fonts.latoRegular(size: 17)
        }
        
        if #available(iOS 11.0, *) {
            // Search controller cancelButton
            let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: Colors.navTitleColor,
                                          NSAttributedString.Key.font: Fonts.latoRegular(size: 14)]
            UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes , for: .normal)
            
            // Search controller Background color
            if let first = self.searchController.searchBar.subviews.first {
                for textField in first.subviews where textField is UITextField {
                    textField.subviews.first?.backgroundColor = .white
                    textField.subviews.first?.layer.cornerRadius = 10.5
                    textField.subviews.first?.layer.masksToBounds = true
                }
            }
            
            self.navigationItem.searchController = self.searchController // Place SearchController
        } else {
            // Search controller cancelButton
            let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: Colors.navBottomColor]
            UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes , for: .normal)
            
            self.tableView.tableHeaderView = searchController.searchBar // Place SearchController
        }
    }
    
}


extension BaseTVC: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}
extension BaseTVC: UISearchBarDelegate {
    
    public func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchBar.text!)
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
//        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
//        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
        return searchController.isActive
    }
    
    // Should be overriden, for custom filtering
    @objc func filterContentForSearchText(_ searchText: String) {
    }
    
}
