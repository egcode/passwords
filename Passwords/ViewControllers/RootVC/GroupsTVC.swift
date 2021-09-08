//
//  GroupsTVC.swift
//  Passwords
//
//  Created by Eugene G on 9/8/21.
//

import UIKit

class GroupsTVC: UITableViewController {
        
    
    // MARK: - init/deinit
    
    @objc public static func initFromStoryboard() -> GroupsTVC {
        let sb = UIStoryboard(name: "RootVC", bundle: Bundle(for: GroupsTVC.self))
        guard let grpsTVC = sb.instantiateViewController(withIdentifier: "GroupsTVCID") as? GroupsTVC else {
            print("⛔️ Error getting GroupsTVCID from storyboard")
            return GroupsTVC()
        }
        return grpsTVC
    }
    
    deinit {
        print("GroupsTVC deinited")
    }


    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.lightGray

        
    }
    
    
        
}
