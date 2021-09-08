//
//  Constants.swift
//  Passwords
//
//  Created by Eugene G on 9/8/21.
//

import Foundation

@objcMembers open class Constants: NSObject {
    
    
    open class KeychainKey: NSObject {
        public static var cacheKey = "cacheKey"
    }
        
    public class func buildNumber () -> String? {
       if let appBuild = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") {
            return "\(appBuild)"
        } else {
            return nil
        }
    }
    
    public class func versionNumber() -> String? {
        if let appVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") {
            return "\(appVersion)"
        } else {
            return nil
        }
    }

}
