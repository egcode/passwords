//
//  UINavigationBar+Gradient.swift
//  Passwords
//
//  Created by Eugene G on 9/9/21.
//

import UIKit

public extension UINavigationBar {
    
    @objc func applyGlobalNavbarColor() {
        
        self.applyTitleAttributes()
//        self.tintColor = Colors.navTintColor
//        self.barTintColor = Colors.navBGColor

         // Legacy Gradient Navbar
        let bgimage = UINavigationBar.imageWithGradient(size: CGSize(width: UIScreen.main.bounds.size.width, height: 1))
        self.barTintColor = UIColor(patternImage: bgimage!)
    }
    
    @objc class func imageWithGradient( size:CGSize, horizontally:Bool = true) -> UIImage? {
        let bottomColor = Colors.navBottomColor.cgColor
        let topColor = Colors.navTopColor.cgColor
        
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        gradientLayer.colors = [topColor, bottomColor]
        if horizontally {
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        } else {
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        }
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
        return nil
    }
    
    @objc func applyTitleAttributes() {
        let textAttributes = [NSAttributedString.Key.foregroundColor:Colors.navTitleColor,
                              NSAttributedString.Key.font: Fonts.latoBold(size: 15)]
        self.titleTextAttributes = textAttributes
    }
    
}

