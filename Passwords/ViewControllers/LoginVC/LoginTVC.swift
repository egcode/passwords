//
//  LoginTVC.swift
//  Passwords
//
//  Created by Eugene G on 9/17/21.
//

import UIKit

class LoginTVC: BaseTVC {
        
    var users = [User]()
    var filteredUsers = [User]()
    
    // MARK: - init/deinit
    
    @objc public static func initFromStoryboard() -> LoginTVC {
        let sb = UIStoryboard(name: "RootVC", bundle: Bundle(for: LoginTVC.self))
        guard let loginTVC = sb.instantiateViewController(withIdentifier: "LoginTVCID") as? LoginTVC else {
            Log.debug("⛔️ Error getting LoginTVCID from storyboard")
            return LoginTVC()
        }
        return loginTVC
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        Log.error("LoginTVC inited without storyboard. It should not happen")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Log.debug("LoginTVC inited")
    }
    
    deinit {
        Log.debug("LoginTVC deinited")
    }


    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Collections"
        self.applyLargeTitles()
        self.applyGlobalNavbarClearColor()
//        self.setupSearchBar()

        self.users = DataManager.shared.cacheGetAllUsers()
        
        // Remove Search bar
        self.searchController.searchBar.isHidden = true
        self.navigationItem.searchController = nil

        // Navigation bar Button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(self.actionNavBarButton(sender:)))
    }
    
    // MARK: - Trait Collection. Dark/Light modes change

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.applyGlobalNavbarClearColor()
    }
    
    // MARK: - Actions
    @objc func actionNavBarButton(sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Name collection", message: "Name your new collection", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak self] action in
            self?.refreshTableView(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak alert] (_) in
            if let al = alert, let tfs = al.textFields, let tf = tfs.first, let newName = tf.text {
            
            DataManager.shared.cacheCreateUser(userName: newName) { [weak self] newUser in
                self?.users.append(newUser)
                self?.refreshTableView(animated: true)
            }
            
        } else {
            self.showAlert(title: "Internal errow", message: "")
        }
        }))
        self.present(alert, animated: true, completion: nil)

        
        
    }

    
        
}
