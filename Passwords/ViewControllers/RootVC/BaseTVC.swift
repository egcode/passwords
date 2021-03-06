//
//  BaseTVC.swift
//  Passwords
//
//  Created by Eugene G on 9/9/21.
//

import UIKit

public class BaseTVC: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Lifecycle
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()  // remove empty cells and separators
    }
    
    // MARK: - Helpers
    
    func applyLargeTitles() {
        // Large Title
        self.navigationController?.applyLargeTitle()
    }
    
    func applyGlobalNavbarBlueColor() {
        // Navbar gradient
        self.navigationController?.navigationBar.applyGlobalNavbarBlueColor()
    }
    
    func applyGlobalNavbarClearColor() {
        // Navbar gradient
        self.navigationController?.navigationBar.applyGlobalNavbarClearColor()
    }

    
    // MARK: - Refresh

    func refreshTableView(animated: Bool = true) {
        if animated {
            UIView.transition(with: tableView,
                              duration: 0.3,
                              options: .transitionCrossDissolve,
                              animations: { self.tableView.reloadData() })
        } else {
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - TTL
    
    func checkForTTL() {
        if let ttl = DataManager.shared.TTL {
            let currentDate = Date()
            if ttl > currentDate {
                Log.debug("TTL session is still OK. TTL: \(ttl)   CurrentDate:\(currentDate)")
            } else {
                StartupVC.showLogin(title: "Sessin is expired (TTL)", message: "")
            }
        } else {
            StartupVC.showLogin(title: "No TTL", message: "")
        }
    }

    
}
