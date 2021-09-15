//
//  PasswordsTVC.swift
//  Passwords
//
//  Created by Eugene G on 9/8/21.
//

import UIKit

protocol PasswordsTVCRefreshProtocol: AnyObject {
    func addPassword(passwordVM:PasswordViewModel)
    func refreshFromDelegate()
}

class PasswordsTVC: BaseTVC {
        
    var passwordViewModelParent = PasswordViewModelParent()
    
    // MARK: - init/deinit
    
    @objc public static func initFromStoryboard() -> PasswordsTVC {
        let sb = UIStoryboard(name: "RootVC", bundle: Bundle(for: PasswordsTVC.self))
        guard let passwordsTVC = sb.instantiateViewController(withIdentifier: "PasswordsTVCID") as? PasswordsTVC else {
            Log.debug("⛔️ Error getting PasswordsTVCID from storyboard")
            return PasswordsTVC()
        }
        return passwordsTVC
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        Log.error("PasswordsTVC inited without storyboard. It should not happen")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Log.debug("PasswordsTVC inited")
    }
    
    deinit {
        Log.debug("PasswordsTVC deinited")
    }


    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Passwords"
        
        // Navigation bar Button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(self.actionNavBarButton(sender:)))
    }
    
    // MARK: - Actions
    @objc func actionNavBarButton(sender: UIBarButtonItem) {
        let passCreateVC = PasswordCreateEditVC.initFromStoryboard()
        passCreateVC.delegate = self
        let pcNC = UINavigationController(rootViewController: passCreateVC)
        self.present(pcNC, animated: true, completion: nil)
    }

    
        
}

extension PasswordsTVC: PasswordsTVCRefreshProtocol {
    
    func addPassword(passwordVM: PasswordViewModel) {
        self.passwordViewModelParent.addPasswordViewModel(passwordVM: passwordVM)
        self.refreshTableView(animated: false)
    }
    
    func refreshFromDelegate() {
        self.refreshTableView(animated: false)
    }

}
