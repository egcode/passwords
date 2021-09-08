//
//  PasswordCreateVC.swift
//  Passwords
//
//  Created by Eugene G on 9/8/21.
//

import UIKit

class PasswordCreateVC : UIViewController {
    
    // MARK: - init/deinit
    
    @objc public static func initFromStoryboard() -> PasswordCreateVC {
        let sb = UIStoryboard(name: "RootVC", bundle: Bundle(for: PasswordCreateVC.self))
        guard let passwordCreateVC = sb.instantiateViewController(withIdentifier: "PasswordCreateVCID") as? PasswordCreateVC else {
            print("⛔️ Error getting PasswordCreateVCID from storyboard")
            return PasswordCreateVC()
        }
        return passwordCreateVC
    }
    
    deinit {
        print("PasswordCreateVC deinited")
    }

    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation bar Button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(self.actionNavBarButton(sender:)))
    }
    
    
    // MARK: - Actions
    @objc func actionNavBarButton(sender: UIBarButtonItem) {
        self.dismiss(animated: true) {
        }
    }

    
}
