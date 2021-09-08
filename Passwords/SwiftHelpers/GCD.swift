//
//  GCD.swift
//  Passwords
//
//  Created by Eugene G on 9/8/21.
//

import Foundation

public class GCD: NSObject {
    
    public class func mainThread(block:@escaping () -> Void) {
        DispatchQueue.main.async {block()}
    }
    
    public class func mainThreadDelayed(delay: TimeInterval, block:@escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {block()}
    }
    
    public class func backgroundThread(block:@escaping () -> Void) {
        DispatchQueue.global(qos: .background).async {block()}
    }
    
    public class func backgroundThreadDelayed(delay: TimeInterval, block:@escaping () -> Void) {
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + delay) {block()}
    }
    
    
    static let cacheQueue = DispatchQueue(label: "com.cache.queue", qos: .background)
    public class func cacheThread(block:@escaping () -> Void) {
        GCD.cacheQueue.async {block()}
    }

}
