//
//  Passcode.swift
//  Passwords
//
//  Created by Eugene G on 9/17/21.
//

import LocalAuthentication

open class Passcode: NSObject {
        
    public static func isDevicePasscodeSet() -> Bool {
        //checks to see if devices (not apps) passcode has been set
        if #available(iOS 9.0, *) {
            return LAContext().canEvaluatePolicy(.deviceOwnerAuthentication, error: nil)
        } else {
            // Fallback on earlier versions
            return false
        }
    }
    
    public static func  authenticateUser(message: String, completion: @escaping (_ authenticated: Bool, _ error: Error?) -> Void) {
        let context = LAContext()
        
        if #available(iOS 9.0, *) {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: message) { (success, error) in
                DispatchQueue.main.async {
                    completion(success, error)
                }
            }
        } else {
            DispatchQueue.main.async {
                completion(false, nil) // should never be execuded due to isDevicePasscodeSet will be false for older devices
            }
        }
    }
    
}

