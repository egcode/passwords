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
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.searchBarStyle = UISearchBar.Style.minimal
        // Search controller cancelButton
        self.searchController.searchBar.setValue("Cancel", forKey:"cancelButtonText")
        
        // Search controller cancelButton
        let cancelButtonAttributes = [NSAttributedString.Key.foregroundColor: Colors.navTintColor,
                                      NSAttributedString.Key.font: Fonts.latoRegular(size: 14)]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes , for: .normal)

        // Search textField textColor
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: Colors.navTintColor]
        
        // Search textField icon color
        self.searchController.searchBar.searchTextField.leftView?.tintColor = Colors.navTintColor
        
        self.navigationItem.searchController = self.searchController // Place SearchController
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



extension UISearchBar {
    var textField: UITextField? {
        return subviews.first?.subviews.compactMap { $0 as? UITextField }.first
    }
}
