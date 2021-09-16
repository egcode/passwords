//
//  SettingsTVC.swift
//  Passwords
//
//  Created by Eugene G on 9/8/21.
//

import UIKit

class SettingsTVC: BaseTVC {
    
    struct Segment {
        var title: String
        var processTypes = [String]()
    }
    var sect = [Segment]()
    
    
    // MARK: - init/deinit
    
    @objc public static func initFromStoryboard() -> SettingsTVC {
        let sb = UIStoryboard(name: "RootVC", bundle: Bundle(for: SettingsTVC.self))
        guard let grpsTVC = sb.instantiateViewController(withIdentifier: "SettingsTVCID") as? SettingsTVC else {
            print("⛔️ Error getting SettingsTVCID from storyboard")
            return SettingsTVC()
        }
        return grpsTVC
    }
    
    deinit {
        print("SettingsTVC deinited")
    }


    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        
        // Remove Search bar
        self.searchController.searchBar.isHidden = true
        if #available(iOS 11.0, *) {
            self.navigationItem.searchController = nil
        } else {
            self.tableView.tableHeaderView = nil
        }
        
        self.sect.append(Segment(title: "Security", processTypes: ["Password Protection",
                                                                         "Touch/Face ID"
]))
        self.sect.append(Segment(title: "Export", processTypes: ["Export Plist",
                                                                  "Import Plist"
                                                                      ]))
        
    }
    
        
}
