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
        
//        completion(true, nil)

        
        let context = LAContext()
        
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthentication, localizedReason: message) { (success, error) in
                DispatchQueue.main.async {
                    completion(success, error)
                }
            }
        } else {
            if let err = error {
                if #available(iOS 11.0, *) {
                    switch err.code {
                    case LAError.Code.biometryNotEnrolled.rawValue:
                        completion(false, "User is not enrolled" as? Error)
                    case LAError.Code.passcodeNotSet.rawValue:
                        completion(false, "Pass code not set" as? Error)
                    case LAError.Code.biometryNotAvailable.rawValue:
                        completion(false, "Biometrics are not available" as? Error)
                    default:
                        completion(false, "Pass code not set" as? Error)
                    }
                } else {
                    // Fallback on earlier versions
                }

            }
        }
        
    }
    
    
}

