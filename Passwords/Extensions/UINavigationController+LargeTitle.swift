//
//  UINavigationController+LargeTitle.swift
//  Passwords
//
//  Created by Eugene G on 9/9/21.
//

import UIKit

public extension UINavigationController {
    @objc func applyLargeTitle(titleColor:UIColor = Colors.navTitleColor) {
        if #available(iOS 11.0, *) {
            self.navigationBar.prefersLargeTitles = true
            self.navigationItem.largeTitleDisplayMode = .automatic
            
            let originalFont = UIFont.preferredFont(forTextStyle: .largeTitle)
            self.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: titleColor,
                                                           NSAttributedString.Key.font: Fonts.latoBold(size: originalFont.pointSize)]
        } else {
            // Fallback on earlier versions
        }
    }
}
