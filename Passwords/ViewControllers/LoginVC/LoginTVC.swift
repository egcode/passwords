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
        
        // Long press
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(LoginTVC.longPress(longPressGestureRecognizer:)))
        longPressRecognizer.minimumPressDuration = 3
        self.view.addGestureRecognizer(longPressRecognizer)
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

    // MARK: - Long Press
    
    @objc func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {

        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {
            let touchPoint = longPressGestureRecognizer.location(in: self.view)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                
                if self.isFiltering() {
                    let selUser = self.filteredUsers[indexPath.row]
                    self.handleLongPress(user: selUser)
                } else {
                    let selUser = self.users[indexPath.row]
                    self.handleLongPress(user: selUser)
                }
                
                
            }
        }
    }

    func handleLongPress(user: User) {
        Log.debug("🔑LONG PRESS SELECTED user: \(user.name)")
        
        // -- Security Question Login
        Log.debug("🆔 Using Security question")
        
        if let settingsPass = user.settingsPassword {
            let alert = UIAlertController(title: "Answer question: ", message: settingsPass.userSecurityQuestion, preferredStyle: .alert)
            alert.addTextField { (textField) in
                textField.placeholder = "Answer"
            }
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak self] action in
                self?.refreshTableView(animated: true)
            }))
            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak alert] (_) in
            if let al = alert, let tfs = al.textFields, let tf = tfs.first {
                if tf.text == settingsPass.userSecurityAnswer {
                    Log.debug("🔑 Login with Security Answer")
                    StartupVC.showRootVC(userID: user.id)
                    
                } else {
                    self.showAlert(title: "Wrong Answer", message: "")
                }
            } else {
                self.showAlert(title: "Internal error", message: "")
            }
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            self.showAlert(title: "No Data", message: "No data to handle long press")
        }

    }


        
}
