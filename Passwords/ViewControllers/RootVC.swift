//
//  RootVC.swift
//  Passwords
//
//  Created by Eugene G on 9/8/21.
//

import UIKit

final class RootVC: UITabBarController {

    
    var passwordsTVC: PasswordsTVC!
    var settingsTVC: SettingsTVC!
        
    // MARK: - init/deinit
    
    init() {
        super.init(nibName: nil, bundle: nil)
        print("⛔️ RootVC inited without storyboard. It should not happen")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("RootVC inited and starting to register lifecycle notifications")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        print("RootVC deinited, notifcation observers cleaned")
    }

    // MARK: - VC Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initial
        var activeViewControllers = [UIViewController]()
        let itemTitleOffset = UIOffset(horizontal: 0, vertical: 0)
                
        //𝌏 -- Passwords Tab
        self.passwordsTVC = PasswordsTVC.initFromStoryboard()
        self.passwordsTVC.tabBarItem.image = UIImage(named: "lock")?.withRenderingMode(.alwaysTemplate)
        self.passwordsTVC.tabBarItem.title = "Passwords"
        self.passwordsTVC.tabBarItem.isAccessibilityElement = true;
        self.passwordsTVC.tabBarItem.accessibilityLabel = "PasswordsTab"
        self.passwordsTVC.tabBarItem.titlePositionAdjustment = itemTitleOffset; // Move Title Up
        let viewGroupsNC = UINavigationController(rootViewController: self.passwordsTVC)
        activeViewControllers.append(viewGroupsNC)

        
        //𝌏 -- Settings Tab
        self.settingsTVC = SettingsTVC.initFromStoryboard()
        self.settingsTVC.tabBarItem.image = UIImage(named: "settings")?.withRenderingMode(.alwaysTemplate)
        self.settingsTVC.tabBarItem.title = "Settings"
        self.settingsTVC.tabBarItem.isAccessibilityElement = true;
        self.settingsTVC.tabBarItem.accessibilityLabel = "SettingsTab"
        self.settingsTVC.tabBarItem.titlePositionAdjustment = itemTitleOffset; // Move Title Up
        let settingsNC = UINavigationController(rootViewController: self.settingsTVC)
        activeViewControllers.append(settingsNC)

        self.viewControllers = activeViewControllers
        
//        UITabBar.appearance().tintColor = ARColor.tabbarSelectedTabTint
        self.tabBar.isTranslucent = false
        // Fixes UIKit bug when tabbar doesn't layout UINavigation controller properly.
        self.tabBar.isTranslucent = true

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }

    
    
}
