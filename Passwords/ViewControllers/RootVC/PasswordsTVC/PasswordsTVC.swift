//
//  PasswordsTVC.swift
//  Passwords
//
//  Created by Eugene G on 9/8/21.
//

import UIKit

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
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didBecomeActive),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        Log.debug("PasswordsTVC deinited")
    }


    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Passwords"
        self.applyLargeTitles()
        self.applyGlobalNavbarBlueColor()
        self.setupSearchBar()
        
        
        // Navigation bar Button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(self.actionNavBarButton(sender:)))
        
        self.navigationItem.hidesSearchBarWhenScrolling = false

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.2) {
            self.tableView.setContentOffset(CGPoint(x: self.tableView.contentOffset.x, y: self.tableView.contentOffset.y-1), animated: false)
        }

        self.checkForTTL()
    }

    @objc func didBecomeActive() {
        self.checkForTTL()
    }

    
    // MARK: - Trait Collection. Dark/Light modes change

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.applyGlobalNavbarBlueColor()
    }
    
    // MARK: - Actions
    @objc func actionNavBarButton(sender: UIBarButtonItem) {
        let passCreateVC = PasswordCreateEditVC.initFromStoryboard()
        passCreateVC.delegate = self
        let pcNC = UINavigationController(rootViewController: passCreateVC)
        self.present(pcNC, animated: true, completion: nil)
    }
    
        
}
