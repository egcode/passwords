//
//  UINavigationBar+Gradient.swift
//  Passwords
//
//  Created by Eugene G on 9/9/21.
//

import UIKit

public extension UINavigationBar {
    
    @objc func applyGlobalNavbarBlueColor() {
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
    
    @objc func applyGlobalNavbarClearColor() {
        self.tintColor = Colors.navTintColor

        // Also Apply attributes for all Large Titles modes
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithTransparentBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: Colors.clear]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: Colors.textDarkGrey]
        navBarAppearance.backgroundColor = Colors.clear
        self.standardAppearance = navBarAppearance
        self.scrollEdgeAppearance = navBarAppearance
    }

    
}

