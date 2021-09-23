//
//  UINavigationBar+Gradient.swift
//  Passwords
//
//  Created by Eugene G on 9/9/21.
//

import UIKit

public extension UINavigationBar {
    
    @objc func applyGlobalNavbarBlueColor() {
        self.isTranslucent = true
        
        var titleColor = Colors.clear
        var bgColor = Colors.clear
        
        switch traitCollection.userInterfaceStyle {
            case .light, .unspecified:
                self.tintColor = Colors.navTintColor
                titleColor = Colors.navTintColor
                bgColor = Colors.navBGColor
            case .dark:
                self.tintColor = Colors.navTintColor
                titleColor = Colors.lightGray
                bgColor = Colors.darkGray
        @unknown default:
            fatalError()
        }

        // Also Apply attributes for all Large Titles modes
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: titleColor]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: titleColor]
        navBarAppearance.backgroundColor = bgColor
        self.standardAppearance = navBarAppearance
        self.scrollEdgeAppearance = navBarAppearance
        
        self.isTranslucent = false

    }
    
    @objc func applyGlobalNavbarClearColor() {
        
        switch traitCollection.userInterfaceStyle {
            case .light, .unspecified:
                self.tintColor = Colors.darkGray
            case .dark:
                self.tintColor = Colors.navTintColor
        @unknown default:
            fatalError()
        }

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

