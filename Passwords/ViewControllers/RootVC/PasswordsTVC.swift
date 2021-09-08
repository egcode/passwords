//
//  PasswordsTVC.swift
//  Passwords
//
//  Created by Eugene G on 9/8/21.
//

import UIKit

class PasswordsTVC: UITableViewController {
        
    
    // MARK: - init/deinit
    
    @objc public static func initFromStoryboard() -> PasswordsTVC {
        let sb = UIStoryboard(name: "RootVC", bundle: Bundle(for: PasswordsTVC.self))
        guard let passwordsTVC = sb.instantiateViewController(withIdentifier: "PasswordsTVCID") as? PasswordsTVC else {
            print("⛔️ Error getting PasswordsTVCID from storyboard")
            return PasswordsTVC()
        }
        return passwordsTVC
    }
    
    deinit {
        print("PasswordsTVC deinited")
    }


    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation bar Button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(self.actionNavBarButton(sender:)))

        
    }
    
    // MARK: - Actions
    @objc func actionNavBarButton(sender: UIBarButtonItem) {
        let passCreateVC = PasswordCreateVC.initFromStoryboard()
        let pcNC = UINavigationController(rootViewController: passCreateVC)
        self.present(pcNC, animated: true, completion: nil)

    }

    
        
}
