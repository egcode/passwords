//
//  Fonts.swift
//  Passwords
//
//  Created by Eugene G on 9/9/21.
//

import UIKit

@objcMembers public class Fonts: NSObject {
    
    public class func latoRegular(size:CGFloat) -> UIFont {
        if #available(iOS 8.2, *) {
            return UIFont(name: "Lato-Regular", size: size) ?? UIFont.systemFont(ofSize: size, weight: UIFont.Weight.regular)
        } else {
            return UIFont.systemFont(ofSize: size)
        }
    }
    
    public class func latoLight(size:CGFloat) -> UIFont {
        if #available(iOS 8.2, *) {
            return UIFont(name: "Lato-Light", size: size) ?? UIFont.systemFont(ofSize: size, weight: UIFont.Weight.thin)
        } else {
            return UIFont.systemFont(ofSize: size)
        }
    }
    
    public class func latoBold(size:CGFloat) -> UIFont {
        if #available(iOS 8.2, *) {
            return UIFont(name: "Lato-Bold", size: size) ?? UIFont.systemFont(ofSize: size, weight: UIFont.Weight.bold)
        } else {
            return UIFont.systemFont(ofSize: size)
        }
    }
    
}

