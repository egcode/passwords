//
//  RootVC.swift
//  Passwords
//
//  Created by Eugene G on 9/8/21.
//

import UIKit

final class RootVC: UITabBarController {

    
    var groupsTVC: GroupsTVC!
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
                
        //𝌏 -- Groups Tab
        self.groupsTVC = GroupsTVC.initFromStoryboard()
        self.groupsTVC.tabBarItem.image = UIImage(named: "lock")?.withRenderingMode(.alwaysTemplate)
        self.groupsTVC.tabBarItem.title = "Groups"
        self.groupsTVC.tabBarItem.isAccessibilityElement = true;
        self.groupsTVC.tabBarItem.accessibilityLabel = "GroupsTab"
        self.groupsTVC.tabBarItem.titlePositionAdjustment = itemTitleOffset; // Move Title Up
        let viewGroupsNC = UINavigationController(rootViewController: self.groupsTVC)
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
