//
//  UINavigationBar+Gradient.swift
//  Passwords
//
//  Created by Eugene G on 9/9/21.
//

import UIKit

public extension UINavigationBar {
    
    @objc func applyGlobalNavbarColor() {
        self.tintColor = Colors.navTintColor

        // Also Apply attributes for all Large Titles modes
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: Colors.navTintColor]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: Colors.navTintColor]
        navBarAppearance.backgroundColor = Colors.navBGColor
        self.standardAppearance = navBarAppearance
        self.scrollEdgeAppearance = navBarAppearance
    }
    
}

